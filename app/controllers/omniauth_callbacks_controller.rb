class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def linkedin
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except("extra")
    ret = User.sign_in_from_omniauth(auth)
    user = User.find(ret.user_id)
    sign_in_and_redirect user, notice: "Signed in"
  end

  def destroy
    session[:omniauth] = nil
    session[:user_id] = nil
    redirect_to root_url, notice: "signed_out"
  end

  alias_method :facebook, :linkedin

end