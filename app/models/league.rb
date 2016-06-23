class League < ApplicationRecord
  has_many :seasons
  has_many :teams, through: :seasons
  has_many :owners, -> { distinct }, through: :teams
  has_many :games, through: :seasons
  has_many :champions, through: :seasons, source: :teams

  validates :name, presence: true

  def owner_season_records(game_type)
    records = {}
    owners.each do |owner|
      owner_hash = {}
      owner.teams.each do |team|
        ts = team.team_stats(game_type)
        owner_hash[team.season.year] = [ts[:wins], ts[:losses]]
      end
      records[owner.first_name] = owner_hash
    end
    records
  end

  def standings(game_type)
    owners.sort { |x,y| y.over_500(game_type) <=> x.over_500(game_type) }
  end

  def avg_ppg
    total_points = 0
      games.each { |game| total_points += (game.away_score + game.home_score) }
    (total_points / (games.count * 2)).round(1)
  end

  def avg_point_differential
    total = 0
    games.each { |game| total += (game.away_score - game.home_score).abs }
    (total / games.count).round(1)
  end
end
