Rails.application.routes.draw do

	resources :tournaments
	resources :users
	devise_for :users

	authenticated :user do
		root 'tournaments#index', as: :authenticated_root
	end
end
