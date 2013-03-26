ActiveAdmin.register Category do
  menu :if => proc { can?(:manage, Category) }, :priority => 5

end
