class Admin::Contractors::MessagesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contractor = Contractor.find(params[:contractor_id])
    @clients = Client.joins(:messages).where(messages:{sender: @contractor}).or(Client.joins(:messages).where(messages:{receiver: @contractor})).distinct
    @latest_messages = @clients.map do |client|
      @contractor.latest_message(client)
    end.compact
  end

  def show
    @contractor = Contractor.find(params[:contractor_id])
    message = Message.find(params[:id])
    @client = message.sender == @contractor ? message.receiver : message.sender
    @messages = @contractor.message_logs(@client).order(:created_at)
  end

  def destroy
    @contractor = Contractor.find(params[:contractor_id])
    message = Message.find(params[:id])
    @client = message.sender == @contractor ? message.receiver : message.sender
    @messages = @contractor.message_logs(@client).order(:created_at)
    @messages.destroy_all
    flash[:notice] = "success"
    redirect_to admin_contractor_messages_path(@contractor.id)
  end
end