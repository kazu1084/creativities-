class Comment < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :post
end
