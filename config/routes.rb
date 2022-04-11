Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  # resources :users, only: [:index, :new, :create, :show]
  # resources :コントローラー名, only: [:アクション, :アクション]
  resources :prototypes do
    resources :comments, only: [:create]
  end
  # /users/:idのパスでリクエストした際にusers_controller.rbのshowアクションを実行するルーティング
  resources :users, onry: [:show]
end
