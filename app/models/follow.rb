class Follow < ApplicationRecord
  belongs_to :client
  belongs_to :contractor
end
