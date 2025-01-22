class NotificationsController < ApplicationController
  def index
    @current_user = current_client || current_contractor
    @notifications = @current_user.passive_notifications.where.not(visitor_id: @current_user.id).page(params[:page]).per(20)
    @notifications.where(read: false).each do |notification|
      notification.update(read: true)
    end
  end
end
