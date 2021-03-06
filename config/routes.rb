Rails.application.routes.draw do
  # Load all datasets at runtime
  extend MultiDataset
  extend FacetsQuery
  load_everything
  
  get 'search', to: 'search#index'
  get 'docs/makedocview', to: 'docs#makedocview'

  get 'description', to: 'docs#description'
  get 'advancedsearch', to: 'docs#advanced'
  get 'otherresources', to: 'docs#otherresources'
  
  root to: 'docs#index'
  resources :docs

  # Aliases for legacy support
  get 'nsadocs', to: 'docs#index'
  get 'nsadocs/:id', to: 'docs#show'
  
  # Dynamically generate routes
  extend MiscProcess
  @dataspecs.each do |d|
    resources gen_class_name(d).to_sym, controller: 'docs'
    get 'attachments/*path', to: 'docs#attach'
  end

  # Routes for indexing
  get 'find_dataspec' => 'index#find_dataspec'
  match 'add_new_item' => 'index#add_new_item', as: :index_add_new_item, via: [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
