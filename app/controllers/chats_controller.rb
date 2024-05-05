class ChatsController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
    
    @room.user_rooms.each do |user_room|
      if user_room.user_id != current_user.id
        user_room.user.chats.where(room_id: @room.id).update(read: true)
      end
    end
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    unless @chat.save
      render :validater
    end
  end
  
  def index
    @users = []
    current_user.rooms.each do |room| 
      room.user_rooms.each do |user_room| 
        unless user_room.user_id == current_user.id 
          @users << user_room.user
        end
      end
    end
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
end
