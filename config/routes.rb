Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ja/ do
    resources :books
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
    root 'books#index'
  end
end
