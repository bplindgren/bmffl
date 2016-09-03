class League < ApplicationRecord
  has_many :seasons
  has_many :teams, through: :seasons
  has_many :owners, -> { distinct }, through: :teams
  has_many :games, through: :seasons
  has_many :champions, through: :seasons, source: :teams

  validates :name, presence: true

  ALL_TIME_STATS = [{:games_played=>79, :wins=>44, :losses=>35, :ties=>0, :points_for=>6764.5, :points_against=>6856.5, :point_diff=>-92.0, :ppg=>85.63, :papg=>86.79, :ppg_diff=>-1.16, :wp=>0.557, :name=>"Drew M"}, {:games_played=>79, :wins=>43, :losses=>36, :ties=>0, :points_for=>7105.0, :points_against=>6832.0, :point_diff=>273.0, :ppg=>89.94, :papg=>86.48, :ppg_diff=>3.46, :wp=>0.544, :name=>"Brian D"}, {:games_played=>79, :wins=>42, :losses=>37, :ties=>0, :points_for=>6839.0, :points_against=>6691.0, :point_diff=>148.0, :ppg=>86.57, :papg=>84.7, :ppg_diff=>1.87, :wp=>0.532, :name=>"Matt M"}, {:games_played=>78, :wins=>39, :losses=>38, :ties=>1, :points_for=>6434.0, :points_against=>6554.0, :point_diff=>-120.0, :ppg=>82.49, :papg=>84.03, :ppg_diff=>-1.54, :wp=>0.5, :name=>"Nick D"}, {:games_played=>80, :wins=>39, :losses=>41, :ties=>0, :points_for=>6941.0, :points_against=>6976.5, :point_diff=>-35.5, :ppg=>86.76, :papg=>87.21, :ppg_diff=>-0.45, :wp=>0.488, :name=>"Kyle P"}, {:games_played=>79, :wins=>38, :losses=>41, :ties=>0, :points_for=>6905.5, :points_against=>7050.5, :point_diff=>-145.0, :ppg=>87.41, :papg=>89.25, :ppg_diff=>-1.84, :wp=>0.481, :name=>"Isaac S"}, {:games_played=>62, :wins=>37, :losses=>25, :ties=>0, :points_for=>5463.0, :points_against=>5018.0, :point_diff=>445.0, :ppg=>88.11, :papg=>80.94, :ppg_diff=>7.17, :wp=>0.597, :name=>"Sean S"}, {:games_played=>79, :wins=>35, :losses=>44, :ties=>0, :points_for=>6749.5, :points_against=>7113.0, :point_diff=>-363.5, :ppg=>85.44, :papg=>90.04, :ppg_diff=>-4.6, :wp=>0.443, :name=>"Brad L"}, {:games_played=>80, :wins=>34, :losses=>46, :ties=>0, :points_for=>6779.5, :points_against=>6885.0, :point_diff=>-105.5, :ppg=>84.74, :papg=>86.06, :ppg_diff=>-1.32, :wp=>0.425, :name=>"Brian K"}, {:games_played=>80, :wins=>32, :losses=>47, :ties=>1, :points_for=>6518.0, :points_against=>6749.5, :point_diff=>-231.5, :ppg=>81.47, :papg=>84.37, :ppg_diff=>-2.9, :wp=>0.4, :name=>"Dan O"}, {:games_played=>15, :wins=>11, :losses=>4, :ties=>0, :points_for=>1519.5, :points_against=>1292.5, :point_diff=>227.0, :ppg=>101.3, :papg=>86.17, :ppg_diff=>15.13, :wp=>0.733, :name=>"Ryan D"}]

  def generate_all_time_stats(stat, game_type)
    stats_array = []
    owners.each do |owner|
      owner_hash = owner.owner_stats(game_type)
      owner_hash[:name] = owner.full_name
      stats_array.push(owner_hash)
    end
    stats_array
  end

  def sort_all_time_stats(stat, game_type)
    League::ALL_TIME_STATS.sort_by { |hash| hash[stat] }.reverse()
  end

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
