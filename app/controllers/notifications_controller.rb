class NotificationsController < ApplicationController
  before_action :logged_in_only

  def list
    @notifications = Notification.all
  end
end
