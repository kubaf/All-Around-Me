module SessionsHelper
  
  # half hour cookie sign in session
  def sign_in(user)
    #cookies[:session_token] = {value: user.session_token, expires: Time.now + 30.minutes}
    session[:session_token] = user.session_token
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    session.delete(:session_token)
  end
    
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  # filter that checks if user is allowed to execute on a particular action
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "You must be signed in to perform this action." 
    end
  end
  
  # filter that checks that user only executes actions against their own data
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  # filter that only allows you to edit your own reviews
  def correct_review
    @review = Review.find(params[:id])
    redirect_to(root_path) unless current_user?(@review.user)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
end
