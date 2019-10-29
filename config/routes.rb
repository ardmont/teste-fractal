Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # namespace the controllers without affecting the URI
  namespace :api do
    namespace :v1 do
      resources :artists, :musics, :albums
    end
  end
end
