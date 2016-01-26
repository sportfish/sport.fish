Rails.application.routes.draw do
	root 'tournaments#index'

	devise_for :users
	resources :users
	resources :tournaments
end
