#This task should be run daily
task :send_reminders => :environment do
  Enrollment.send_reminders
end

#This task should be run daily
task :issue_queued_refunds => :environment do
  Enrollment.refund_queued
end