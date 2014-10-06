Rails.application.routes.draw do

	resources 'friendships'

  	get 'search' =>'places#search'
  	get 'search_result' =>'places#search_result'
  	get 'visits/all' => 'visits#all'

  	resources :visits, only: :index

  	resources :places do
    	resources :visits, except: :index
	end

    root 'welcome#index'
    resources :users
    post 'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'

end
