ActiveAdmin.register Location do

  form do |f|
    f.inputs "Location" do
   	  f.input :title
   	  f.input :longitude
   	  f.input :latitude
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
