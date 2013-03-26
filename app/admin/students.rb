ActiveAdmin.register Student do
actions :all, :except => [:destroy,:edit,:new,:create]
  menu :if => proc{ can?(:manage, Student) }, :priority => 7

  index do |s|
		column :id
		column :email
		column "Name" do |st|
			st.forename + " " + st.surname
		end
		default_actions
	end
  
end
