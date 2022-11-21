Rails.application.routes.draw do
  resources :endpoints
  match '*path' => 'application#echo', via: [:get, :post, :patch, :put, :delete]
end
