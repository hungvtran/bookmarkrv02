Rails.application.routes.draw do
  get 'bookmarks/new'

  root 'static_pages#home'
  get 'upload_file' => 'users#upload_file'
  get 'signup' => 'users#new'
  get 'profile' => 'users#show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'bookmarks' => 'users#bookmarks'
  get 'users/new'
  resources :users
end
