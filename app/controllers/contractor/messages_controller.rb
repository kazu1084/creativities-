class Contractor::MessagesController < ApplicationController
  before_action :authenticate_contractor!

  def new
    @client = Client.find(params[:client_id])
    @message = Message.new
  end

  def index
    clients = Client.joins(:messages).where(messages:{sender: current_contractor}).or(Client.joins(:messages).where(messages:{receiver: current_contractor}))
    first_message = Client.where(id: current_contractor.messages.select(:receiver_id))  #selecメソッドで送信相手のidを検索して取得
    @clients = (clients + first_message).uniq
    @latest_messages = @clients.map do |client|
      current_contractor.latest_message(client)
    end.compact
  end

  def show
    @client = Client.find(params[:id])
    @messages = current_contractor.message_logs(@client).order(:created_at)
    @message = Message.new
  end

  def create
    @client = Client.find(params[:message][:receiver_id])
    @message = current_contractor.messages.build(receiver: @client)
    @message.assign_attributes(message_params)
    if @message.save
      redirect_to contractor_message_path(@client)
    else
      @messages = current_contractor.message_logs(@client).order(:created_at)
      render "contractor/messages/show"
    end

  end

  private

  def message_params
    params.require(:message).permit(:body, :image, :video)
  end
end
