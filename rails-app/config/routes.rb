Rails.application.routes.draw do
  
  resources :books, :only => [:index, :show]
  resources :borrowers
  resources :book_loans


  get '/welcome/search', to: 'welcome#search'
  root 'welcome#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
