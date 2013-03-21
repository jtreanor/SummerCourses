ActiveAdmin.register Teacher do


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
end
