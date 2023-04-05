Rails.application.routes.draw do
  resources :categories
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :users
end
