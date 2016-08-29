class User < ApplicationRecord
  has_secure_password
  has_many :votes, :foreign_key => :voter_id

  validates :username, presence: true, length: { minimum: 6 }
  validates :email, uniqueness: true, length: { minimum: 6 }
  validates :password, length: { in: 6..20 }

end
