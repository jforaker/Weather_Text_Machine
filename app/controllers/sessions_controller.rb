class SessionsController < ApplicationController

  def new
    redirect_to '/auth/twitter'
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
# Reset the session after successful login, per
# 2.8 Session Fixation – Countermeasures:
# http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    user.permalink =    User.where(
                                   :permalink => auth['info']['name'] || "")
    reset_session
    session[:user_id] = user.id
    if user.phone.blank?
      redirect_to root_url(user), :alert => "Enter your info to get the weather"
    else
      redirect_to root_url, :notice => 'Signed in!'
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
