class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :redirect_session, only: [:show]
  before_action :login_new, only: [:new]
  skip_before_action :login_required, only: [:new, :create]
  
  def new
    if current_user.present?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "新規登録しました.ログインしました"
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash.now[:notice] = "登録に失敗しました"
      render :new
    end
  end

  def show
  end  

  private

  def user_params
    params.require(:user).permit(:password_confirmation,:password,:name,:email,:admin_or_not)
  end 
  
  def set_user
    @user = User.find(params[:id])
  end

  #もしユーザーが登録ユーザーではなく、また、管理者でもなければ権限がありませんと表示させる。
  def redirect_session
    if @user.id != current_user.id && !current_user.admin?
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def admin_user
    if current_user.admin
      redirect_to(user_path) unless current_user.admin?
    end
  end
#ログイン中のユーザーが会員（管理者）でなければマイページへ飛ぶ
  def login_new
    if log_in? && !current_user.admin?
      redirect_to user_path(current_user)
    end
  end

end