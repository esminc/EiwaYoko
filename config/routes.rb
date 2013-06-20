Hackathon::Application.routes.draw do
  root to: 'members#index'

  get 'oauth2authorize' => 'auth#oauth2authorize'
  get 'oauth2callback'  => 'auth#oauth2callback'
  get 'auth/result'

  resources :members, only: [:index, :show]
end
