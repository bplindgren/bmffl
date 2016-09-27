class League < ApplicationRecord
  has_many :seasons
  has_many :teams, through: :seasons
  has_many :owners, -> { distinct }, through: :teams
  has_many :games, through: :seasons
  has_many :champions, through: :seasons, source: :teams

  validates :name, presence: true

  ALL_TIME_STATS = [{:games_played=>82, :wins=>44, :losses=>38, :ties=>0, :points_for=>7111.0, :points_against=>7006.0, :point_diff=>105.0, :ppg=>86.72, :papg=>85.44, :ppg_diff=>1.28, :wp=>0.537, :name=>"Matt M"}, {:games_played=>82, :wins=>37, :losses=>45, :ties=>0, :points_for=>7016.5, :points_against=>7400.0, :point_diff=>-383.5, :ppg=>85.57, :papg=>90.24, :ppg_diff=>-4.67, :wp=>0.451, :name=>"Brad L"}, {:games_played=>62, :wins=>37, :losses=>25, :ties=>0, :points_for=>5463.0, :points_against=>5018.0, :point_diff=>445.0, :ppg=>88.11, :papg=>80.94, :ppg_diff=>7.17, :wp=>0.597, :name=>"Sean S"}, {:games_played=>18, :wins=>13, :losses=>5, :ties=>0, :points_for=>1798.5, :points_against=>1518.0, :point_diff=>280.5, :ppg=>99.92, :papg=>84.33, :ppg_diff=>15.59, :wp=>0.722, :name=>"Ryan D"}, {:games_played=>82, :wins=>44, :losses=>38, :ties=>0, :points_for=>6986.5, :points_against=>7126.0, :point_diff=>-139.5, :ppg=>85.2, :papg=>86.9, :ppg_diff=>-1.7, :wp=>0.537, :name=>"Drew M"}, {:games_played=>83, :wins=>34, :losses=>48, :ties=>1, :points_for=>6812.5, :points_against=>7006.0, :point_diff=>-193.5, :ppg=>82.08, :papg=>84.41, :ppg_diff=>-2.33, :wp=>0.41, :name=>"Dan O"}, {:games_played=>83, :wins=>41, :losses=>42, :ties=>0, :points_for=>7228.0, :points_against=>7231.5, :point_diff=>-3.5, :ppg=>87.08, :papg=>87.13, :ppg_diff=>-0.05, :wp=>0.494, :name=>"Kyle P"}, {:games_played=>82, :wins=>44, :losses=>38, :ties=>0, :points_for=>7404.5, :points_against=>7138.5, :point_diff=>266.0, :ppg=>90.3, :papg=>87.05, :ppg_diff=>3.25, :wp=>0.537, :name=>"Brian D"}, {:games_played=>81, :wins=>39, :losses=>41, :ties=>1, :points_for=>6633.5, :points_against=>6861.0, :point_diff=>-227.5, :ppg=>81.9, :papg=>84.7, :ppg_diff=>-2.8, :wp=>0.481, :name=>"Nick D"}, {:games_played=>83, :wins=>36, :losses=>47, :ties=>0, :points_for=>7073.0, :points_against=>7093.0, :point_diff=>-20.0, :ppg=>85.22, :papg=>85.46, :ppg_diff=>-0.24, :wp=>0.434, :name=>"Brian K"}, {:games_played=>82, :wins=>40, :losses=>42, :ties=>0, :points_for=>7163.0, :points_against=>7292.0, :point_diff=>-129.0, :ppg=>87.35, :papg=>88.93, :ppg_diff=>-1.58, :wp=>0.488, :name=>"Isaac S"}]

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
