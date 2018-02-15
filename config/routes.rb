Rails.application.routes.draw do

  scope 'api' do
    resources :posts do
      resources :comments
    end
    resources :categories
    resources :users do
      collection do
        post 'login'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
