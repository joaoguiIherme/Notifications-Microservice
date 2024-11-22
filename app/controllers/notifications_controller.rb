class NotificationsController < ApplicationController
  def create
    notification = Notification.new(notification_params)

    if notification.save
      render json: { message: 'Notification saved successfully' }, status: :created
    else
      render json: { errors: notification.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def index
    notifications = Notification.where(task_id: params[:task_id])
    render json: notifications, status: :ok
  end

  private

  def notification_params
    params.require(:notification).permit(:task_id, :event_type, :details)
  rescue ActionController::ParameterMissing
    {}
  end

end
