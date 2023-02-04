Rails.application.routes.draw do
  
  # 管理者用
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
 # 会員用
  devise_for :users, skip:[:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  
end
