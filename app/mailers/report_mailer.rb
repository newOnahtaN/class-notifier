class ReportMailer < ActionMailer::Base
  default from: 'natesclassnotifier@gmail.com'

  def report_mailer new_classes
    @new_classes = new_classes
    if new_classes.present?
      Rails.logger.info "Sending email"
      mail(to: ["ncowen@email.wm.edu", "elsawyer@email.wm.edu"] , subject: "New CS Courses Available!")
    else
      Rails.logger.info "No new classes, no email sent"
    end
  end

end
