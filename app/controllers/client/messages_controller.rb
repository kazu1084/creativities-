class Client::MessagesController < ApplicationController

  def new
    @contractor = Contractor.find(params[:contractor_id])
    @message = Message.new
  end

  def index
    @contractors = Contractor.joins(:messages).where(messages:{sender: current_client}).or(Contractor.joins(:messages).where(messages:{receiver: current_client})).distinct
    @latest_messages = @contractors.map do |contractor|
      current_client.latest_message(contractor)
    end.compact
  end

  def show
    @contractor = Contractor.find(params[:id])
    @messages = current_client.message_logs(@contractor).order(:created_at)
    @message = Message.new
  end

  def create
    @contractor = Contractor.find(params[:message][:receiver_id])
    @message = current_client.messages.build(receiver: @contractor)
    @message.assign_attributes(message_params)
    if @message.save
      redirect_to client_message_path(@contractor)
    else
      @messages = current_client.message_logs(@contractor).order(:created_at)
      render "client/messages/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :video)
  end
end
