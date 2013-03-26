namespace :db do
  desc 'Fill database with sample student/teacher data'
  task populate: :environment do
    make_users
    #make_teachers
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
    )
    teacher = Teacher.create(
        :is_active => true, :description => Faker::Lorem.paragraph(10), :admin_user_id => admin.id
    )
    teacher.admin_user.admin_permission_id = 3
    teacher.save
  end
end

def make_courses
  for n in 1..20 do
    course = Course.create!(:title => Faker::Lorem.sentence,
                            :description => Faker::Lorem.paragraph(10),
                            :brief_description => Faker::Lorem.sentence(10),
                            :teacher_id => 1,
                            :number_of_places => 50+n,
                            :price => 100.0+n,
                            :deposit => 10.0+n,
                            :category_id => Category.first.id,
                            :hits => n)
    start_date = n.month.since
    for i in 1..3 do
      course.time_table_items.create(
          location_id: Location.first.id,
          start_time: i.day.since + start_date,
          end_time: i.day.since+2.hours + start_date,
          room: 'G' + n.to_s
      )
    end
    for i in 4..7 do
      course.time_table_items.create(
          location_id: Location.last.id,
          start_time: i.day.since + start_date,
          end_time: i.day.since+2.hours + start_date,
          room: 'G' + n.to_s
      )
    end
  end
  for n in 1..20 do
    course = Course.create!(:title => Faker::Lorem.sentence,
                            :description => Faker::Lorem.paragraph(10),
                            :brief_description => Faker::Lorem.sentence(10),
                            :teacher_id => n,
                            :number_of_places => 50+n,
                            :price => 100.0+n,
                            :deposit => 10.0+n,
                            :category_id => Category.last.id,
                            :hits => n)
    start_date = n.month.since
    for i in 1..3 do
      course.time_table_items.create(
          location_id: Location.first.id,
          start_time: i.day.since + start_date,
          end_time: i.day.since+2.hours + start_date,
          room: 'G' + n.to_s
      )
    end
    for i in 4..7 do
      course.time_table_items.create(
          location_id: Location.last.id,
          start_time: i.day.since + start_date,
          end_time: i.day.since+2.hours + start_date,
          room: 'G' + n.to_s
      )
    end
  end

end


