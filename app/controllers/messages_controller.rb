class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    message = Message.new
    message.body = params[:message][:body]
    message.user_id = Current.user.id
    message.room_id = params[:message][:room_id].to_i
    message.save
    room = Room.find(message.room_id)
    redirect_to view_room_path(id: room.course_id)
  end

  def destroy
    @message = Message.find(params[:id].to_i)
    debugger
  end

end
