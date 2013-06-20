Hackathon::Application.routes.draw do
  get 'members/index'
  get 'members/show'
  get 'oauth2authorize' => 'auth#oauth2authorize'
  get 'oauth2callback'  => 'auth#oauth2callback'
  get 'auth/result'
end
