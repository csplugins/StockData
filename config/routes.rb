Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  root 'welcome#index'
  get 'search' => 'welcome#index'
  post 'search' => 'welcome#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
