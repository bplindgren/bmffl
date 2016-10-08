class League < ApplicationRecord
  has_many :seasons
  has_many :teams, through: :seasons
  has_many :owners, -> { distinct }, through: :teams
  has_many :games, through: :seasons
  has_many :champions, through: :seasons, source: :teams

  validates :name, presence: true

  def generate_all_time_stats(stat, game_type)
    stats_array = []
    owners.each do |owner|
      owner_hash = owner.owner_stats(game_type)
      owner_hash[:name] = owner.full_name
      stats_array.push(owner_hash)
    end
    stats_array
  end

  # def sort_all_time_stats(stat, game_type)
  #   League::ALL_TIME_STATS.sort_by { |hash| hash[stat] }.reverse()
  # end

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



  # def sort_teams_by(stat, game_type)
  #   stats_hash = {}
  #   teams.each do |team|
  #     stats_hash[team.name] = team.team_stats(game_type)[stat].round(2)
  #   end
  #   p stats_hash
  #   order = stats_hash.sort_by { |k, v| v }.reverse
  # end

  def avg_point_differential
    total = 0
    games.each { |game| total += (game.away_score - game.home_score).abs }
    (total / games.count).round(1)
  end
end
