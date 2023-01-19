namespace :api do
  namespace :v1, defaults: { format: :json } do
    get :status, to: 'api#status'
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :reservations #, only: %i[create, update]
  end
end
