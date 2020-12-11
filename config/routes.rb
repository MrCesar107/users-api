Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index create update] do
    resource :welcome, only: %i[show], controller: 'users/welcome'
  end

  resources :sessions, only: %i[create destroy], controller: 'users/sessions'
end
