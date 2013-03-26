ActiveAdmin.register Teacher do
  menu :if => proc{ can?(:manage, Teacher) }, :priority => 8
  actions :all, except: [:destroy]

  index do
    id_column
    column :state do |t|
      if t.is_active == true
        status_tag 'active', :ok
      else
        status_tag 'inactive'
      end

    end
    column :surname do |t|
      t.admin_user.surname
    end
    column :forename do |t|
      t.admin_user.forename
    end
    column :email do |t|
      t.admin_user.email
    end
    column :current_sign_in_at do |t|
      t.admin_user.current_sign_in_at
    end
    column :last_sign_in_at do |t|
      t.admin_user.last_sign_in_at
    end
    column :sign_in_count do |t|
      t.admin_user.sign_in_count
    end
    default_actions
  end

  show do |t|
    attributes_table do
      row :id
      row :statue do
        if t.is_active == true
          status_tag 'active', :ok
        else
          status_tag 'inactive'
        end
      end
      row :surname do
        t.admin_user.surname
      end
      row :forename do
        t.admin_user.forename
      end
      row :email do
        t.admin_user.email
      end
      row :description
      row :current_sign_in_at do
        t.admin_user.current_sign_in_at
      end
      row :last_sign_in_at do
        t.admin_user.last_sign_in_at
      end
      row :sign_in_count do
        t.admin_user.sign_in_count
      end
      row :teacher_picture do
        unless t.image.nil?
          link_to(image_tag(t.image.asset.url(:thumb)), t.image.asset.url(:medium))
        end
      end
    end
    active_admin_comments
  end


  form :html => {:multipart => true} do |f|
    #f.inputs 'Existing Image  do
    #  f.input :image
    #end
    f.inputs 'Teacher Information', :for => [:admin_user, f.object.admin_user || AdminUser.new] do |fm|
      fm.input :surname
      fm.input :forename
      fm.input :email
    end
    f.inputs 'Teacher Description' do
      f.input :description
    end
    f.inputs 'Active Or Deactive' do
      f.input :is_active
    end
    f.inputs :'Teacher Image', :for => [:image, Image.new] do |fm|
      if f.object.image.nil?
        fm.input :asset, :as => :file
      else
        fm.input :asset, :as => :file, :hint => f.template.image_tag(f.object.image.asset.url(:thumb))
      end
    end

    f.buttons
  end

end
