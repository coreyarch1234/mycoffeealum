class ConnectionsController < ApplicationController
  def index
      @users = User.all
      @connections = Connection.all
  end

  def new
      @connection = Connection.new
  end

  def create
      @connection = Connection.new(connection_params)
      mentor = User.find(params[:mentee_id])
      mentee = User.find(params[:mentor_id])
      connection = Connection.create!(mentee_id: mentee.id, mentor_id: mentor.id)

      # create conversation between mentee and mentor

      @conversation = Conversation.create({ sender_id: mentor.id, recipient_id: mentee})
      # message from mentor to mentee
      @conversation.message.create()
      # message from mentee to mentor
      @conversation.message.create()

      redirect_to users_path
  end

  def destroy
  end


  private

  #Define the tuple that includes the mentor and mentee id in the connection
  # class ConnectID < Struct.new(:mentee_id, :mentor_id)
  #
  # end
  # def createTuple(mentee_id, mentor_id)
  #   @connectArray = []
  #   @connectID = ConnectID.new mentee_id, mentor_id
  #   @connectArray.push(connectID)
  # end
  # def createSomething
  #   @connectArray = []
  #   @connectID = OpenStruct.new
  #   @connectID[:mentee_id] = 0
  #   @connectID[:mentee_id] = 0
  #
  # end

  def connection_params
    params.permit(:mentee_id, :mentor_id)
  end


end
