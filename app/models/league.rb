class League < ApplicationRecord
  has_many :seasons
  has_many :teams, through: :seasons
  has_many :owners, -> { distinct }, through: :teams
  has_many :games, through: :seasons
  has_many :champions, through: :seasons, source: :teams

  validates :name, presence: true

  ALL_TIME_STATS = [{:games_played=>81, :wins=>44, :losses=>37, :ties=>0, :points_for=>7078.0, :points_against=>6901.0, :point_diff=>177.0, :ppg=>87.38, :papg=>85.2, :ppg_diff=>2.18, :wp=>0.543, :name=>"Matt M"}, {:games_played=>81, :wins=>37, :losses=>44, :ties=>0, :points_for=>6912.5, :points_against=>7258.0, :point_diff=>-345.5, :ppg=>85.34, :papg=>89.6, :ppg_diff=>-4.26, :wp=>0.457, :name=>"Brad L"}, {:games_played=>62, :wins=>37, :losses=>25, :ties=>0, :points_for=>5463.0, :points_against=>5018.0, :point_diff=>445.0, :ppg=>88.11, :papg=>80.94, :ppg_diff=>7.17, :wp=>0.597, :name=>"Sean S"}, {:games_played=>17, :wins=>13, :losses=>4, :ties=>0, :points_for=>1715.5, :points_against=>1413.0, :point_diff=>302.5, :ppg=>100.91, :papg=>83.12, :ppg_diff=>17.79, :wp=>0.765, :name=>"Ryan D"}, {:games_played=>81, :wins=>44, :losses=>37, :ties=>0, :points_for=>6905.5, :points_against=>7039.0, :point_diff=>-133.5, :ppg=>85.25, :papg=>86.9, :ppg_diff=>-1.65, :wp=>0.543, :name=>"Drew M"}, {:games_played=>82, :wins=>33, :losses=>48, :ties=>1, :points_for=>6670.5, :points_against=>6902.0, :point_diff=>-231.5, :ppg=>81.35, :papg=>84.17, :ppg_diff=>-2.82, :wp=>0.402, :name=>"Dan O"}, {:games_played=>82, :wins=>40, :losses=>42, :ties=>0, :points_for=>7128.5, :points_against=>7168.5, :point_diff=>-40.0, :ppg=>86.93, :papg=>87.42, :ppg_diff=>-0.49, :wp=>0.488, :name=>"Kyle P"}, {:games_played=>81, :wins=>43, :losses=>38, :ties=>0, :points_for=>7299.5, :points_against=>7055.5, :point_diff=>244.0, :ppg=>90.12, :papg=>87.1, :ppg_diff=>3.02, :wp=>0.531, :name=>"Brian D"}, {:games_played=>80, :wins=>39, :losses=>40, :ties=>1, :points_for=>6569.5, :points_against=>6761.5, :point_diff=>-192.0, :ppg=>82.12, :papg=>84.52, :ppg_diff=>-2.4, :wp=>0.488, :name=>"Nick D"}, {:games_played=>82, :wins=>35, :losses=>47, :ties=>0, :points_for=>6968.0, :points_against=>7060.0, :point_diff=>-92.0, :ppg=>84.98, :papg=>86.1, :ppg_diff=>-1.12, :wp=>0.427, :name=>"Brian K"}, {:games_played=>81, :wins=>39, :losses=>42, :ties=>0, :points_for=>7077.0, :points_against=>7211.0, :point_diff=>-134.0, :ppg=>87.37, :papg=>89.02, :ppg_diff=>-1.65, :wp=>0.481, :name=>"Isaac S"}]

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
