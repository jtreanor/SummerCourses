ActiveAdmin.register Student do
  menu :if => proc{ can?(:manage, Student) }
  
end
