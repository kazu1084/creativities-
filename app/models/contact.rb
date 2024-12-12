class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true
  validates :body, presence: true
end
