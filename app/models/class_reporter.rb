require 'capybara'
class ClassReporter

  def find_new_classes
    @new_classes = ["A new CS course"]
    @session = Capybara::Session.new(:selenium)
    @session.visit "https://courselist.wm.edu/courselist/"
    node = @session.find_field("term_code")
    terms = node.all("*").map {|t| t.text}
    terms.each do  |term|
      find_differences(REDIS.get(term), query_term(term))
    end

  end

  def query_term term
    @session.select("Computer Science", from: "term_subj")
    @session.select(term, from: "term_code")
    @session.find_button('search').click
    classes = collect_classes
    @session.visit "https://courselist.wm.edu/courselist/"
    return classes
  end

  def collect_classes
    @session.all('tr').map do |tr|
      Rails.logger.info Course.new tr.native.find_elements(:tag_name, 'td')
    end
  end

  def known_classes 
    REDIS.get('known_classes')
  end

  def refresh_known_classes
    REDIS.set('known_classes', @new_classes)
  end

  def email_report
    ReportMailer.report_mailer(@new_classes).deliver!
  end

end


