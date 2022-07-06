class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  enum role: {
    seller: 0,
    realtor: 1
  }
end
