ActiveAdmin.register Category do
  actions :all, :except => [:destroy]
  menu :if => proc { can?(:manage, Category) }, :priority => 5

end
