task :class_report => :environment do
  reporter = ClassReporter.new
  puts "Finding new CS Courses"
  reporter.find_new_classes
  puts "Sending Email"
  reporter.email_report
  puts "Done"
end
