Rails.application.routes.draw do
  get 'callback/index'
  get 'callback/recieved_data'
  root 'callback#index'
end
