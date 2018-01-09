class Checkin < ApplicationRecord
  has_and_belongs_to_many :feelings
  belongs_to :user
end
