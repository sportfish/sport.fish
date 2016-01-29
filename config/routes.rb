Rails.application.routes.draw do

	resources :invites
	resources :tournaments
	devise_for :users

	authenticated :user do
		root 'tournaments#index', as: :authenticated_root
	end
end
