class ConnectionsController < ApplicationController
  def index
      @users = User.all
      @connections = Connection.all
      @conversations = Conversation.all
  end

  def new
      @users = User.all
      @connection = Connection.new
  end

  def create
      @mentor = User.find(params[:mentor_id])
      @mentee = User.find(params[:mentee_id])
      @connection = Connection.create!(mentee_id: @mentee.id, mentor_id: @mentor.id)
      if Conversation.between(params[:sender_id],params[:recipient_id]).present?
          @conversation = Conversation.between(params[:sender_id],
          params[:recipient_id]).first
      else
          @conversation = Conversation.create!(sender_id: @mentee.id, recipient_id: @mentor.id)
      end
      redirect_to conversation_messages_path(@conversation)

  end

  def destroy
  end


  private

  def connection_params
    params.permit(:mentee_id, :mentor_id)
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
