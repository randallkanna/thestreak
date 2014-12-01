helpers do
  def current_user
    if session[:user_id]
      @user ||= User.find(session[:user_id])
    end
  end

  def require_user
    redirect '/' unless current_user
  end
end