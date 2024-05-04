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
    unless ProfileViewCount.where(created_at: Time.zone.now.all_day).find_by(viewer_id: current_user.id, viewed_id: @user.id)
      current_user.active_views.create(viewed_id: @user.id)
    end
  end

  def index
    if params[:latest]
      @users = User.latest
    elsif params[:old]
      @users = User.old
    else
      @users = User.all
    end
  end
  
  def post_index
    @user = User.find(params[:user_id])
    @recommend_place_posts = @user.recommend_place_posts
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
