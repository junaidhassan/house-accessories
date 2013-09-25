HouseAccessories::Application.routes.draw do

  resources :items do
    collection { post :import}
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all  your routes lay out with "rake routes".
  get 'save-results' => 'items#save_results', as: :save_results
  get 'upload' => 'items#new_import', as: :upload
  # You can have the root of your site routed with "root"
  root 'items#index'

end
