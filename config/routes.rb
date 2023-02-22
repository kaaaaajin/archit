Rails.application.routes.draw do
  
  # 管理者用
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
 # 会員用
  devise_for :users, skip:[:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
  }
  
  # ゲストログイン用
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
  
  namespace :admin do
     delete "users/destroy_all" => "users#destroy_all", as: "destroy_all"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end
  
  scope module: :public do
     root "homes#top"
     get "homes/about" => "homes#about", as: "about"
     get "users/unsubscribe" => "users#unsubscribe"
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
  	  get "followings" => "relationships#followings", as: "followings"
  	  get "followers" => "relationships#followers", as: "followers"
  	  collection do
       get :favorites
      end
    end
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
        resource :likes, only: [:create, :destroy]
    end 
    
    
  end
    
     
      

  
end
