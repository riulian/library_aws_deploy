Rails.application.routes.draw do
  get 'home/index'
  get 'home/signup'
  get 'home/show'
  post 'home/create'
  get 'books/rent_a_book'
  post 'books/rentabookrented'
  patch 'books/rentabookrented'
  delete 'books/destroy_booksuser'
  get 'books/return_a_book'
  post 'books/returnabook'
  patch 'books/returnabook'
  get 'books/my_rented_books'
  get 'books/all_rented_books'
  get 'books/search'
  resources :books
  #devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # Defines the root path route ("/")
  #devise_scope :user do
    #root to: 'devise/sessions#new'
  #end
  root "books#index"
end
