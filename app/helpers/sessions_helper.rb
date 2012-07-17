module SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:session_token] = user.session_token
    self.current_user = user
  end
  
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(cookies[:session_token])
  end
  
end
