class ClassReporter

  def find_classes
    #will generate @new_classes
    #use selenium	 
    @new_classes = ["A new CS course"] 
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


