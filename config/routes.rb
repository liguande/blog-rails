Rails.application.routes.draw do
  root 'welcome#index'
  get "about" => "welcome#about" ,:as => "about"
  get "users/sign_in" => "users#sign_in", :as => "sign_in"
  post "users/sign_in_session" => "users#sign_in_session", :as => "sign_in_session"
  delete "users/logout" => "users#logout" ,:as => "logout"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
