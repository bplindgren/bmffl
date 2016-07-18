class Vote < ApplicationRecord
  belongs_to :voter, :class_name => 'User'
  belongs_to :game
  belongs_to :team

  validates_uniqueness_of :voter_id, :scope => :game_id
end
