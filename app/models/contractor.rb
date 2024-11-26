class Contractor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :comments, dependent: :destroy, as: :user
  has_many :bookmarks, dependent: :destroy, as: :user
  has_many :contractor_follows, dependent: :destroy
  has_many :clients, through: :contractor_follows
  has_many :messages, as: :sender
  has_many :reviews, dependent: :destroy

  def message_logs(client)
    Message.where(sender: self,receiver: client).or(Message.where(sender: client,receiver: self))
  end

  def latest_message(client)
    Message.where(sender: self, receiver: client)
      .or(Message.where(sender: client, receiver: self))
      .order(created_at: :desc).limit(1).first
  end

  def follow(client)
    self.contractor_follows.find_or_create_by(client: client)
  end

  def unfollow(client)
    self.contractor_follows.find_by(client: client)&.destroy
  end

  def following?(client)
    self.clients.include?(client)
  end

 def get_profile_image(width,height)
    unless profile_image.attached?
    file_path=Rails.root.join('app/assets/images/default-image.jpg')
    profile_image.attach(io:File.open(file_path),filename:"default-image.jpg",content_type:"image/jpeg")
    end
    profile_image.variant(resize_to_limit:[width,height]).processed
 end
end
