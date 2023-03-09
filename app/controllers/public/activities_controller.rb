class Public::ActivitiesController < ApplicationController
    before_action :authenticate_user!
    
  def index
    @activities  = current_user.activities.order(created_at: :desc).page(params[:page]).per(15)
      
  end
  
  def read
    current_user.activities
    
  
  end
  


  
  
end
