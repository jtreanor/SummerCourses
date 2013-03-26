namespace :db do
  desc 'Fill database with sample student/teacher data'
  task populate: :environment do
    make_users
    make_teacher
    make_microposts
    make_relationships
  end
end

def make_users
  100.times do |n|
    Student.create!(
                  forename:     Faker::Name.first_name,
                  surname:  Faker::Name.last_name,
                 email:    "example-#{n+1}@example.com",
                 password: 'password',
                 password_confirmation: password)
  end

  Student.create([
                     { email: "jtreanor3@gmail.com", forename: "James", surname: "Treanor", password: "password", password_confirmation: "password", year_of_birth: 1991, country_id: "IE", sex_id: 1
                     }])
  s = Student.first
  s.confirmed_at = DateTime.now
  s.save
end
