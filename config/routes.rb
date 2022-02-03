require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
  mount API => '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
