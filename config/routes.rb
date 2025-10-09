Rails.application.routes.draw do
  # Página inicial (dashboard após login)
  root "links#index"

  # Rotas de autenticação manual (sem devise)
  get    "login",  to: "sessions#new"
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Rotas de registro de usuário
  get  "signup", to: "users#new"
  post "users",  to: "users#create"

  # Links encurtados — apenas para usuários logados
  resources :links, only: [:index, :new, :create, :show, :destroy]

  # Redirecionamento ao acessar um link curto
  # Exemplo: /abc123 → redireciona para o link original
  get "/:short_code", to: "links#redirect", as: :short
end
