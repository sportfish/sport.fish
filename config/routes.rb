Rails.application.routes.draw do
	resources :invites
	resources :tournaments do
		member do
			post 'join', controller: :tournament_participation, action: :create
		end
		resources :tournament_participation, as: 'participation', only: [:destroy], path: 'participation'
	end

	devise_for :users

	authenticated :user do
		root 'tournaments#index', as: :authenticated_root
	end
end
