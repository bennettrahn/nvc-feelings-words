class User < ApplicationRecord
  has_many :checkins

  validates :username, presence: true
  validates :username, uniqueness: true

  validates :password, presence: true

end
