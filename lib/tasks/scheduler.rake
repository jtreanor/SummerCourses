#This task should be run daily
task :send_course_reminders => :environment do
  Enrollment.send_course_reminders
end

#This task should be run daily
task :send_payment_reminders => :environment do
  Enrollment.send_payment_reminders
end

#This task should be run daily
task :issue_queued_refunds => :environment do
  puts "Refunding Users"
  10.times do |i|
  	puts "Reminding user #{i}"
  end
  puts "Done."
end