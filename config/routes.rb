GrubVote::Application.routes.draw do
	root 'welcome#index'

	resources :grub_sessions,
		only: [:index, :new, :create] do
		member do
			post :close
		end
	end

	resources :votes,
		only: [:show, :update]

	resources :restaurants,
		only: [:index]

	resources :friends,
		only: [:index]

	get "oauth/callback" => "oauths#callback"
	get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
	get "logout" => "user_sessions#destroy", :as => :logout
end
