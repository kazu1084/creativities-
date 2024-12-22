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
    @contractor = Contractor.find(params[:id])
    @messages = @client.message_logs(@contractor).order(:created_at)
  end

  def destroy
    
  end
end