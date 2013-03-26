ActiveAdmin.register Location do
  menu :if => proc{ can?(:manage, Location) }, :priority => 6
  actions :all, :except => [:destroy]

  form do |f|
    f.inputs "Location" do
   	  f.input :title
   	  f.input :longitude
   	  f.input :latitude, :hint => "#{link_to "This site", "http://gps.ie/gps-lat-long-finder.htm"} may be useful for finding coordinates."
    end

    f.buttons
  end

  index do
    column :id
    column "Title" do |c|
          link_to c.title, admin_location_path(c)
    end
    column :longitude
    column :latitude
    default_actions
  end
  
end
