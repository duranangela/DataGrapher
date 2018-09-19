Rails.application.routes.draw do
  root 'welcome#index'
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  delete 'sign-out', to: 'sessions#destroy', as: 'sign-out'

  namespace :api do
    namespace :v1 do
      get '/graphs', to: "graphs#index"
    end
  end


end
