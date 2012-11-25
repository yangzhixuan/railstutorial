module SessionsHelper

  attr_writer :current_user

  def current_user 
    @current_user ||= user_from_remember_token
  end

  def sign_in(user, remember_me = "no")
    cookie = cookies.signed
    cookie = cookie.permanent if remember_me == "yes"
    cookie[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil  
  end

  def signed_in?
    return !current_user.nil?  
  end

  private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
