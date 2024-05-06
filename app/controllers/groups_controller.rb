class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
    @category = Category.find(params[:category_id])
    @group = Group.new
  end
  def create
    category = Category.find(params[:category_id])
    @group = category.groups.new(group_params)
    if @group.save
      GroupCategory.create(category_id: category.id, group_id: @group.id)
      redirect_to category_group_path(category.id, @group.id), notice: '新しく表題が作成されました。'
    else
      render :new
    end
  end

  def index
    @category = Category.find(params[:category_id])
    @groups = @category.groups
  end

  def show
    @category = Category.find(params[:category_id])
    @group = Group.find(params[:id])
  end

  def edit
    @category = Category.find(params[:category_id])
    @group = Group.find(params[:id])
  end

  def update
    category = Category.find(params[:category_id])
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to category_group_path(category.id, @group.id), notice: '表題の内容が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

  def ensure_correct_user
    group = Group.find(params[:id])
    unless group.owner_id == current_user.id
      redirect_to category_groups_path
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end
end
