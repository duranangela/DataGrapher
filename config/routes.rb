Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :v1 do
      get '/graphs', to: "graphs#index"
    end
  end
end
