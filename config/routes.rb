Rails.application.routes.draw do
  get '/index', to: 'sudokus#index'
  get '/test', to: 'sudokus#test'
  post 'usesudoku', to: 'sudokus#usesudoku'
  get '/index2', to: 'tests#index'
  get 'sudoku/index'
  patch 'sudoku/update'
end
