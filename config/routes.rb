Puttputthooray::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  get 'profile/my_profile' => "profile#my_profile"
  
  resources :profile do
    collection do
      get :add_user
      post :add_user
      post :create
      get :offers
    end
  end
  root 'profile#show'
  namespace :admin do
    resources :colleges
    resources :courses
  end

  resources :admin do
    member do
      put :change_role
      get :shadow_user
    end

    collection do
      get :members
      get :stop_shadow_user
      get :search
    end
  end
  resources :courses do
    collection do
      get 'find'
      get 'find_by_state'
      get 'find_by_college'
      get :autocomplete_golf_facility_company
      get :autocomplete_college_name
    end
    member do
      post 'suggest'
    end
  end
end
