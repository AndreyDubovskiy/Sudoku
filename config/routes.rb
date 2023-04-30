Rails.application.routes.draw do
  get '/index', to: 'sudokus#index'
  #afdasfadsfdasf
  get '/index2', to: 'tests#index'
  get 'sudoku/index'
  patch 'sudoku/update'
end
