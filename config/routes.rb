Rails.application.routes.draw do
  resources :wall_messages
  resources :invitaciones_quedades
  get 'friends/index'
  delete 'friends/destroy'
  resources :friend_requests
  resources :quedadas
  resources :invitaciones_quedades
  resources :recordatorios
  resources :users do
    member do
      get :confirm_email
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'login', to: 'authentication#authenticate'
  # Users
  get 'searchUserByName', to: 'users#searchUserByName'
  get 'searchUserByMail', to: 'users#searchUserByMail'
  put 'updateUsers', to: 'users#updateUsers'
  get 'myProfile', to: 'users#myProfile'
  # Pleasures
  post 'createGusto', to: 'pleasure#createGusto'
  get 'getGustos', to: 'pleasure#getGustos'
  # UserPelasures
  get 'usuariosMismoGusto/:title', to: 'user_pleasure#usuariosMismoGusto'
  post 'definirGusto', to: 'user_pleasure#definirGusto'
  # Mails
  post 'sendMail', to: 'messages#sendMail'
  get 'getMails', to: 'messages#getMails'
  get 'getMailsNotReaded', to: 'messages#getMailsNotReaded'
  get 'getSendedMails', to: 'messages#getSendedMails'
  post 'markAsReaded', to: 'messages#markAsReaded'
  #muro
  post 'wall_messages/:id', to: 'wall_messages#create_specific'
  delete 'wall_messages', to: 'wall_messages#deleteAll'
  #Tableros
  post 'quedadas/:id/tableros', to: 'tableros#create'
  get 'quedadas/:id/tableros', to: 'tableros#show'
  delete 'quedadas/:id/tableros', to: 'tableros#destroy'
  put 'quedadas/:id/tableros', to: 'tableros#update'
  #get ''
end
