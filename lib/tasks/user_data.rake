namespace :db do
  desc 'Fill database with sample student/teacher data'
  task populate: :environment do
    make_users
  end
end

def make_users
  for n in 1..50 do
    student = Student.new(
        forename: Faker::Name.first_name,
        surname: Faker::Name.last_name,
        email: "example-#{n+1}@example.com",
        password: 'password',
        password_confirmation: 'password',
        year_of_birth: 1991, country_id: n%100, sex_id: n%2
    )
    student.confirmed_at = DateTime.now
    student.save
  end
end

def make_teachers
  for n in 1..50 do

    admin = AdminUser.create(
        :forename => Faker::Name.first_name,
        :surname => Faker::Name.last_name,
        :email => 'teacher@example.com',
        :password => 'password',
        :password_confirmation => 'password',
        :admin_permission_id => AdminPermission.last.id
    )
    Teacher.create(
        :is_active => true, :description => Faker::Lorem.paragraph(10), :admin_user_id => admin.id
    )
  end
end
