Rails.application.routes.draw do

	resources 'friendships'

	get 'search' =>'places#search'
	get 'search_result' =>'places#search_result'

  get 'visits/:id/addphoto' => 'visits#addphoto', as: "addphoto"

  patch 'visits/:id/createphoto' => 'visits#createphoto', as: "createphoto"

	resources :visits, only: :destroy do
		resources :recommendations, only: [:create, :new]
	end

	resources :places, except: :index do
  	resources :visits, except: :index
  end

  root 'welcome#index'
  resources :users do
  	resources :recommendations, only: :index
  	resources :visits, only: :index
  end
  resources :recommendations, only: [:destroy, :show]

  post 'sessions' => 'sessions#create'
  delete 'sessions' => 'sessions#destroy'

end
