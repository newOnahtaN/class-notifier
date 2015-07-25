class ClassReporter

  def find_new_classes
    @new_classes = [Course.new(["20924", "CSCI 800 15", "IN", "Dissertation", "Smirni, Evgenia", "1-12", "W", "0800-0850", "3", "0", "3", "OPEN"])]
    report_time = Time.now.to_s
    current_classes = term_codes.map {|term_code| collect_classes term_code}.flatten!
    puts current_classes.reject {|current_class| REDIS.get(current_class.crn).present?}
    current_classes.each {|current_class| REDIS.set(current_class.crn, report_time)}
  end

  def term_codes
    front_page = HTTParty.get('https://courselist.wm.edu/courselist/', :verify => false).parsed_response
    Nokogiri::XML(front_page).xpath("//select[@name='term_code']//option")
      .map {|term| term.attributes['value'].value.to_i}
  end

  def collect_classes term_code
    course_list_page = HTTParty.post('https://courselist.wm.edu/courselist/courseinfo/searchresults',
                                :body =>
                                  { :term_code => term_code,
                                    :term_subj => 'CSCI',
                                    :attr => 0,
                                    :levl => 0,
                                    :status => 0,
                                    :search => 'Search'
                                  },
                                :verify => false)
    courses = Nokogiri::HTML.parse(course_list_page).xpath('//td').map{|td| td.text.strip}.in_groups_of(12)
    courses.map!{|course| Course.new course} 
  end

  def email_report
    ReportMailer.report_mailer(@new_classes).deliver!
  end

end


