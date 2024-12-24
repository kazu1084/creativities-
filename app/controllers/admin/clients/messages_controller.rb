class Admin::Clients::MessagesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @client = Client.find(params[:client_id])
    @contractors = Contractor.joins(:messages).where(messages:{sender: @client}).or(Contractor.joins(:messages).where(messages:{receiver: @client})).distinct
    @latest_messages = @contractors.map do |contractor|
      @client.latest_message(contractor)
    end.compact
  end

  def show
    @client = Client.find(params[:client_id])
    message = Message.find(params[:id])
    @contractor = message.sender == @client ? message.receiver : message.sender
    @messages = @client.message_logs(@contractor).order(:created_at)
  end

  def destroy
    @client = Client.find(params[:client_id])
    message = Message.find(params[:id])
    @contractor = message.sender == @client ? message.receiver : message.sender
    @messages = @client.message_logs(@contractor).order(:created_at)
    @messages.destroy_all
    flash[:notice] = "success"
    redirect_to admin_client_messages_path(@client.id)
  end
end