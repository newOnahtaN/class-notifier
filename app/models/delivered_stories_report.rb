class ClassReporter

  def find_classes
  end

  def time_of_last_report_string
    REDIS.get('time_of_last_report')
  end

  def set_report_time
    REDIS.set('time_of_last_report', Time.now.to_s)
  end

  def email_report
    ReportMailer.delivered_pivotal_stories_mailer(@new_stories, time_of_last_report_string).deliver!
  end

end


