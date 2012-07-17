module SessionsHelper
  
  # half hour cookie sign in session
  def sign_in(user)
    cookies[:session_token] = {value: user.session_token, expires: Time.now + 30.minutes}
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:session_token)
  end
    
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(cookies[:session_token])
  end
  
end
