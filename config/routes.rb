Rails.application.routes.draw do
  resources :notifications, only: [:create, :index]
end
