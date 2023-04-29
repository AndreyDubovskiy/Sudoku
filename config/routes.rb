Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/index', to: 'sudoku_controller#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
