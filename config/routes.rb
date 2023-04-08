Rails.application.routes.draw do
  resources :expenses do
    
  end
  resources :categories
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :users
  get 'expense/latest', to: "expenses#latest"
end
