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
end
