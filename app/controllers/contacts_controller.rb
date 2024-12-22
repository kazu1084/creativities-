class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      flash.now[:alert] = @contact.errors.full_messages.join(',')
      @contact = Contact.new
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to new_contacts_path, notice: "お問い合わせを送信しました。"
    else
      flash.now[:alert] = @contact.errors.full_messages.join(',')
      @contact = Contact.new
      render :new
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :body)
    end
end
