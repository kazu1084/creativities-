class Admin::ContactsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    flash[:notice] = "success"
    redirect_to admin_contacts_path
  end
end