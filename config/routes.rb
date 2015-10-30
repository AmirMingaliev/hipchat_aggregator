Rails.application.routes.draw do
  devise_for :users
  patch "/update", to: "pages#update", as: :update_settings
  root to: "pages#home"
end
