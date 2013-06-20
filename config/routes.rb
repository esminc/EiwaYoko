Hackathon::Application.routes.draw do
  get 'oauth2authorize' => 'auth#oauth2authorize'
  get 'oauth2callback'  => 'auth#oauth2callback'
  get 'auth/result'
end
