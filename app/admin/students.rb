ActiveAdmin.register Student do
  menu :if => proc{ can?(:manage, Student) }, :priority => 7
  
end
