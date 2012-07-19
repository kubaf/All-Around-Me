

def sign_in(user)
  visit signin_path
  fill_in "Email",  with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  
  cookies[:session_token] = user.session_token
end