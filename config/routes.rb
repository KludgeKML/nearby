Nearby::Application.routes.draw do
  resources :items do
    resources :tags
  end
end
