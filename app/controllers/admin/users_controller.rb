class Admin::UsersController < ApplicationController
  # skip_before_action :login_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :destroy_myself, only: [:destroy]
  before_action :require_admin
  def index
    @users = User.all


  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.latest.page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_url(@user), notice: "ユーザー 「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end 

  def edit
  end

  def update
    @user = User.find(params[:id])

    if  @user = User.find(params[:id])
    redirect_to admin_user_url(@user), notice: "ユーザー 「#{@user.name}」を更新しました。"
    else
    render :edit
    end
  end

  def destroy
    # binding.irb
    @user.destroy
    redirect_to admin_users_url, notice:"ユーザー 「#{@user.name}」を削除しました。"
  end

end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def destroy_myself
    if @user == current_user
      redirect_to admin_users_url,
                  notice: "自分自身を削除することは出来ません。"
    end
  end

  def require_admin
    redirect_to user_path(current_user) unless current_user.admin?
  end

