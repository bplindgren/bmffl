class User < ApplicationRecord
  has_secure_password
  has_many :votes, :foreign_key => :voter_id

  validates :username, presence: true
  validates :email, uniqueness: true
end
