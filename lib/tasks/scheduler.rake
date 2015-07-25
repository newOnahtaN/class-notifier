task :class_report => :environment do
  reporter = ClassReporter.new
  Rails.logger.info "Finding new CS Courses"
  reporter.find_new_classes
  reporter.email_report
  Rails.logger.info "Done"
end
