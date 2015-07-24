task :class_report => :environment do
  reporter = ClassReporter.new
  Rails.logger.info "Finding new CS Courses"
  reporter.find_new_classes
  Rails.logger.info "Sending Email"
  reporter.email_report
  Rails.logger.info "Done"
end
