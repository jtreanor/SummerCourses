namespace :db do
  desc 'Fill database with sample student/teacher data'
  task populate: :environment do
    make_users
    make_teachers
    make_courses
  end
end

def make_users
  for n in 1..50 do
    country = Country.all.to_a
    student = Student.new(
        forename: Faker::Name.first_name,
        surname: Faker::Name.last_name,
        email: "student-#{n+1}@example.com",
        password: 'password',
        password_confirmation: 'password',
        year_of_birth: 1991, country_id: country[n%100], sex_id: n%2
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
        :email => "teacher-#{n+1}@example.com",
        :password => 'password',
        :password_confirmation => 'password',
        :admin_permission_id => AdminPermission.last.id
    )
    Teacher.create(
        :is_active => true, :description => Faker::Lorem.paragraph(10), :admin_user_id => admin.id
    )
  end
end

def make_courses
  for n in 1..40 do
    course = Course.create!(:title => Faker::Lorem.sentence,
                        :description => Faker::Lorem.paragraph(10),
                        :brief_description => Faker::Lorem.sentence(10),
                        :teacher_id => n,
                        :number_of_places => 50+n,
                        :price => 100.0+n,
                        :deposit => 10.0+n,
                        :category_id => (n%3)+1,
                        :hits => n)

    for i in 1..7 do
      course.time_table_items.create(
          location_id: Location.first.id,
          start_time: i.day.since,
          end_time: i.day.since+2.hours,
          room: 'G' + n.to_s
      )
    end
  end
end
