class NotificationsController < ApplicationController
  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification.notification_path
  end
end
