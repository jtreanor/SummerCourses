ActiveAdmin.register Teacher do
  actions :all, except: [:destroy]

  index do
    id_column
    column :surname do |t|
      t.admin_user.surname
    end
    column :forename  do |t|
      t.admin_user.forename
    end
    column :email  do |t|
      t.admin_user.email
    end
    column :current_sign_in_at  do |t|
      t.admin_user.current_sign_in_at
    end
    column :last_sign_in_at  do |t|
      t.admin_user.last_sign_in_at
    end
    column :sign_in_count  do |t|
      t.admin_user.sign_in_count
    end
    default_actions
  end

  show do |t|
    attributes_table do
      row :surname  do
        t.admin_user.surname
      end
      row :forename  do
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
      row :sign_in_count  do
        t.admin_user.sign_in_count
      end
      row :teacher_picture do
        unless t.asset.nil?
          link_to(image_tag(t.asset.asset.url(:thumb)), t.asset.asset.url(:medium))
        end
      end
    end
    active_admin_comments
  end


  form :html => {:multipart => true} do |f|
    #f.inputs 'Existing Asset  do
    #  f.input :asset
    #end
    f.inputs 'Teacher Information', :for => [:admin_user, f.object.admin_user || AdminUser.new] do |fm|
      fm.input :surname
      fm.input :forename
      fm.input :email
    end
    f.inputs 'Teacher Description' do
      f.input :description
    end
    f.inputs :'Teacher Picture', :for => [:asset, Asset.new] do |fm|
      fm.input :asset, :as => :file
    end

    f.buttons
  end

end
