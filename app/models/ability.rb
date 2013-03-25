class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new       
    case user.admin_permission.id      
      when 1 #SuperAdmin
        can :manage, :all
      when 2 #Admin
        cannot :manage, AdminUser
      when 3 #Teacher
        can :read, [Course,CourseImage,Image,Student]
      end
  end
end
