class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    redirect_to new_contacts_path
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :body)
    end
end
