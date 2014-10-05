Rails.application.routes.draw do
  root 'places#search'

  get 'search' =>'places#search'
  get 'search_result' =>'places#search_result'
  get 'visits/all' => 'visits#all'

  resources :places do
    resources :visits
  end

end
