class Public::ActivitiesController < ApplicationController
    before_action :authenticate_user!
    
  def index
    @activities  = current_user.activities.includes([:subject]).order(created_at: :desc).page(params[:page]).per(15)
      
  end
  

end
