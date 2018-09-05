Rails.application.routes.draw do

  default_url_options host: "localhost:3000"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  root 'disciplines#index'

  get '/d/:id', to: 'disciplines#show', as: 'd'
  get '/d/:discipline_id/l', to: 'lectures#index', as: 'l'
  get '/d/:discipline_id/l/:id', to: 'lectures#show', as: 'l_id'
  # resources :disciplines, only: [:index, :show] do
  #   resources :lecture, only: [:index, :show]
  #   resources :books, only: :index
  #   resources :videos, only: :index
  # end

  get 'lectures', to: 'client_pages#get_lecture_list'
  get 'lecture', to: 'client_pages#get_lecture_content'
  get 'set_discipline', to: 'client_pages#set_discipline'

  get    '/admin',        to: 'sessions#new'
  post   '/admin',        to: 'sessions#create'
  post   '/admin/auth',   to: 'sessions#auth'
  delete '/logout',       to: 'sessions#destroy'

  namespace :admin do

    resources :msu_filetypes, only: [:create]

    resources :msu_disciplines do
      resources :msu_lectures
      resources :msu_files
      resources :msu_videos, only: [:new, :create, :destroy, :parse]
    end

    resources :msu_lectures do
      resources :msu_presentations
      resources :msu_images
    end
    get 'add_presentation', to: 'msu_presentations#new', as: 'presentation_no_l'
    resources :msu_lectures, only: :index
    resources :msu_users, only: [:index, :new, :create, :destroy]

    get 'msu_discipline/:id/toggle', to: 'msu_disciplines#toggle', as: 'toggle_discipline'
    get 'msu_lecture/:id/toggle', to: 'msu_lectures#toggle', as: 'toggle_lecture'

    get '/reorderlectures', to: 'msu_lectures#reorder'
    get 'upload', to: 'msu_presentations#upload'
  end

end
