Rails.application.routes.draw do
    root 'welcome#index'

    resources :users

    post 'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'

end
