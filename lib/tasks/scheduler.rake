#This task should be run daily
task :send_reminders => :environment do
  puts "Reminding Users"
  10.times do |i|
  	puts "Reminding user #{i}"
  end
  puts "Done."
end

#This task should be run daily
task :issue_queued_refunds => :environment do
  puts "Refunding Users"
  10.times do |i|
  	puts "Reminding user #{i}"
  end
  puts "Done."
end