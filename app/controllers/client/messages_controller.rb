class Client::MessagesController < ApplicationController

  def index
    contractors = Contractor.joins(:messages).where(messages:{sender: current_client}).or(Contractor.joins(:messages).where(messages:{receiver: current_client})).distinct
    @latest_messages = contractors.map do |contractor|
      current_client.latest_message(contractor)
    end.compact
  end

  def create
    @contractor = Contractor.find(params[:contractor_id])
    @message = current_client.messages.build(receiver: @contractor)
    @message.assign_attributes(message_params)
    if @message.save
      redirect_to contractor_path(@contractor)
    else
      render "contractors/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :video)
  end
end
