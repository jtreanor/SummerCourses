SummerCourses::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :students, :controllers => { :regsitrations => 'students/registrations' } 
  resources :categories, only: [:index, :show]
  resources :courses, only: [:show]
  resources :enrollments, only: [:index, :create, :edit]
  resources :messages, only: [:create]
  resources :message_threads, only: [:new, :create] 

  root :to => 'static_pages#home'

  match 'faq' => 'static_pages#faq'

  match 'enrollments/new/course/:id' => 'enrollments#new', :as => :new_enrollment
  match 'enrollments/result/course/:id' => 'enrollments#create', :as => :enrollment_create
  match 'enrollments/cancel/:id' => 'enrollments#cancel', :as => :cancel_enrollment
  match 'enrollments/refund/:id' => 'enrollments#refund', :as => :refund_enrollment, :via => [:post]


  match '/contact' => 'message_threads#new'

  match '/incoming_messages' => 'incoming_messages#create'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
