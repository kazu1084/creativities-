class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: @contact.email, bcc: ENV['MAIL_ADDRESS'], subject: '【Creativitiesお問い合わせについて】'
  end
end