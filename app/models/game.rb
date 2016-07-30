class Game < ApplicationRecord
  belongs_to :season
  belongs_to :away_team, foreign_key: :away_team_id, class_name: 'Team'
  belongs_to :home_team, foreign_key: :home_team_id, class_name: 'Team'
  has_one :away_team_owner, through: :away_team, source: :owner
  has_one :home_team_owner, through: :home_team, source: :owner
  has_one :league, through: :season
  has_many :votes

  validates :season_id, :week, :away_team_id, :home_team_id, :game_type, presence: true

  TYPE = ["All", "Regular Season", "Regular Season & Playoffs", "Playoffs"]

  def winner
    if away_score > home_score
      Team.find(away_team_id)
    elsif home_score > away_score
      Team.find(home_team_id)
    else
      nil
    end
  end

  def loser
    if away_score < home_score
      Team.find(away_team_id)
    elsif home_score < away_score
      Team.find(home_team_id)
    else
      nil
    end
  end

  def point_differential
    (home_score - away_score).abs
  end

end
