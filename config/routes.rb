Rails.application.routes.draw do

  	get 'search' =>'places#search'
  	get 'search_result' =>'places#search_result'
  	get 'visits/all' => 'visits#all'

  	resources :places do
    	resources :visits
	end

    root 'welcome#index'
    resources :users
    post 'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'

end
