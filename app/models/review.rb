class Review < ApplicationRecord
  has_one_attached :image

  belongs_to :contractor
  belongs_to :client
  validates :score, numericality: {
  less_than_or_equal_to: 5,
  greater_than_or_equal_to: 1}, presence: true

  validates :client_id,uniqueness: {scope: :contractor_id}
end
