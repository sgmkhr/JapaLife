class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
    @category = Category.find(params[:id])
    @group = @category.groups.new
  end
  def create
    category = Category.find(params[:id])
    @group = category.groups.new(group_params)
    if @group.save
      redirect_to category_group_path(category.id, @group.id), notice: '新しく表題が作成されました。'
    else
      render :new
    end
  end

  def index
    @category = Category.find(params[:id])
    @groups = @category.groups
  end

  def show
    @category = Category.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def edit
    @group = Group.find(params[:group_id])
  end

  def update
    category = Category.find(params[:id])
    @group = Group.find(params[:group_id])
    if @group.update(group_params)
      redirect_to category_group_path(category.id, @group.id), notice: '表題の内容が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    Group.find(params[:group_id]).destroy
    redirect_to categories_path
  end

  private

  def ensure_correct_user
    group = Group.find(params[:group_id])
    unless group.owner_id == current_user.id
      redirect_to category_groups_path
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end
end
