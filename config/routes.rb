Rails.application.routes.draw do
  resources :users, except: [:edit,:new, :update ] 
  resources :tweets, except: [:edit, :new, :update]

end
