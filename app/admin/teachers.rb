ActiveAdmin.register Teacher do
  actions :all, except: [:destroy]

  index do
    id_column
    column 'Surname' do |t|
      t.admin_user.surname
    end
    column 'Forename' do |t|
      t.admin_user.forename
    end
    column 'Email' do |t|
      t.admin_user.email
    end
    column 'Current Sign In At' do |t|
      t.admin_user.current_sign_in_at
    end
    column 'Last Sign In At' do |t|
      t.admin_user.last_sign_in_at
    end
    column 'Sign In Count' do |t|
      t.admin_user.sign_in_count
    end
    default_actions
  end


  form :html => { :multipart => true } do |f|
    #f.inputs 'Existing Asset' do
    #  f.input :asset
    #end
    f.inputs 'Teacher Information', :for => [:admin_user, f.object.admin_user || AdminUser.new] do |fm|
      fm.input :surname
      fm.input :forename
      fm.input :email
    end
    f.inputs 'Teacher Description' do
      f.input  :description
    end
    f.inputs 'Teacher Picture', :for => [:asset, Asset.new ] do |fm|
      fm.input :asset, :as => :file
    end

    f.buttons
  end

end
