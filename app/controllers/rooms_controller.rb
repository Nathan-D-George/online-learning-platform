class RoomsController < ApplicationController
  def view
    @room = Room.where(course_id: params[:id].to_i).first
    @messages = @room.messages.order(id: :asc)
    @message  = Message.new
  end
end
