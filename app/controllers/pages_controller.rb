class PagesController < ApplicationController
  def home
      redirect_to dashboard_path(current_user) if signed_in?
  end

  def contact
  end
  
  def about
  end
  
  def help
  end
  
end
