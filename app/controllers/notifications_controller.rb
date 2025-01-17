class NotificationsController < ApplicationController
  def index
    @current_user = current_client || current_contractor
    @notifications = @current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
