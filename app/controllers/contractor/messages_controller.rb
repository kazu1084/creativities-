class Contractor::MessagesController < ApplicationController

  def index
    @messages = Message.where(sender: current_contractor)or(Message.where(receiver: current_contractor))
  end

  def create
    @client = Client.find(params[:client_id])
    @message = current_contractor.messages.build(receiver: @client)
    @message.assign_attributes(message_params)
    if @message.save
      redirect_to client_path(@client)
    else
      render "clients/show"
    end

  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :video)
  end
end
