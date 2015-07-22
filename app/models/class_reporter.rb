require 'capybara'
class ClassReporter

  def find_classes
    #will generate @new_classes
    #use selenium	 
    @new_classes = ["A new CS course"]
    session = Capybara::Session.new(:selenium)
    session.visit "https://courselist.wm.edu/courselist/"
    session.select("Computer Science", from: "term_subj")
    node = session.find_field("term_code")
    terms = node.all("*").map {|t| t.text}
    Rails.logger.info terms
    
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


