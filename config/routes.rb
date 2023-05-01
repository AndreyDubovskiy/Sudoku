Rails.application.routes.draw do
  get '/index', to: 'sudokus#index'
  get '/clear', to: 'sudokus#clear'
  get '/ckeck', to: 'sudokus#ckeck'
  get '/enter', to: 'sudokus#enter'
  get '/autofill', to: 'sudokus#autofill'
  post 'usesudoku', to: 'sudokus#usesudoku'
  get '/index2', to: 'tests#index'
  get 'sudoku/index'
  patch 'sudoku/update'
end
