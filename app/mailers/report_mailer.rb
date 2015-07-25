class ReportMailer < ActionMailer::Base
  default from: 'natesclassnotifier@gmail.com'

  def report_mailer new_classes
    @new_classes = new_classes
    if new_classes.present?
      mail(to: ["ncowen@email.wm.edu"] , subject: "New CS Courses Available!")
    end
  end

end
