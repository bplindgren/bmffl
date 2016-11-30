class Season < ApplicationRecord
  has_many :games
  has_many :teams
  has_many :owners, through: :teams
  belongs_to :league

  validates :year, :league_id, :completed?, presence: true

  def standings(game_type, teams)
    teams.sort_by { |team| [ team.team_stats("All")[:wins], team.team_stats("All")[:points_for] ] }.reverse()
  end

  def division_standings(game_type)
    upstairs_teams = teams.select { |team| team.division == "Upstairs" }
    upstairs_standings = standings(game_type, upstairs_teams)

    downstairs_teams = teams.select { |team| team.division == "Downstairs" }
    downstairs_standings = standings(game_type, downstairs_teams)

    { :upstairs => upstairs_standings, :downstairs => downstairs_standings }
  end

  def champion
    super_bowl = games.select { |game| game.game_type == "Super Bowl" }
    if super_bowl.length == 0
      return nil
    else
      super_bowl[0].winner
    end
  end
end
