class GroupUsersController < ApplicationController
  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to category_groups_path(params[:category_id])
  end
end
