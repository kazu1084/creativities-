class Notification < ApplicationRecord
  belongs_to :vistor, polymorphic: true
  belongs_to :visted, polymorphic: true
  belongs_to :notifiable, polymorphic: true
end
