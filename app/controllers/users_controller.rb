class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィール情報を更新しました。'
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :nick_name, :email, :introduction, :profile_image, :role)
  end
  
  def ensure_guest_user
    user = User.find(params[:id])
    if user.guest_user?
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
  def ensure_correct_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to index_path, caution: '他人のユーザー情報は編集できません。'
    end
  end
end
