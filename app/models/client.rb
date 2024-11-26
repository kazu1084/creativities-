class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy, as: :user
  has_many :bookmarks, dependent: :destroy, as: :user
  has_many :client_follows, dependent: :destroy
  has_many :contractors, through: :client_follows
  has_many :messages, as: :sender
  has_many :reviews, dependent: :destroy

  def message_logs(contractor)
    Message.where(sender: self,receiver: contractor).or(Message.where(sender: contractor,receiver: self))
  end

  def latest_message(contractor)
    Message.where(sender: self, receiver: contractor)
      .or(Message.where(sender: contractor, receiver: self))
      .order(created_at: :desc).limit(1).first
  end

  def follow(contractor)
    self.client_follows.find_or_create_by(contractor: contractor)
  end

  def unfollow(contractor)
    self.client_follows.find_by(contractor: contractor)&.destroy
  end

  def following?(contractor)
    self.contractors.include?(contractor)
  end

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path=Rails.root.join("app.assets/images/no_image")
      profile_image.attach(io:File.open(file_path),filename:"default-image.jpg",content_type:"image/jpeg")
    end
    profile_image.variant(resize_to_limit:[width,height]).processed
  end
end
