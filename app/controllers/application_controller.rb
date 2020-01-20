class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :log_in?
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to root_path unless current_user
  end

  #ログインしていないときやマイページなどに飛ばないようにする
  def authenticate_user
    if current_user == nil
      redirect_to root_path
    end
  end

  def admin?
    @user.admin
  end
  
  def log_in?
    @current_user.present?
  end
  
end