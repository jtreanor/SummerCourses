class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new       
    case user.admin_permission.permission_name     
      when "Super Admin" #SuperAdmin
        can :manage, :all
      when "Admin" #Admin
        cannot :manage, AdminUser
      when "Teacher" #Teacher
        can :read, [Course,CourseImage,Image,Student]
      end
  end
end
