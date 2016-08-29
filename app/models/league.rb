class League < ApplicationRecord
  has_many :seasons
  has_many :teams, through: :seasons
  has_many :owners, -> { distinct }, through: :teams
  has_many :games, through: :seasons
  has_many :champions, through: :seasons, source: :teams

  validates :name, presence: true

  ALL_TIME_STATS = {"Brian D"=>{:wins=>43, :losses=>36, :ties=>0, :points_for=>7105.0, :points_against=>6832.0, :point_diff=>273.0, :ppg=>89.9367088607595, :papg=>86.48101265822785, :ppg_diff=>3.455696202531641, :wp=>0.5443037974683544}, "Dan O"=>{:wins=>32, :losses=>47, :ties=>1, :points_for=>6518.0, :points_against=>6749.5, :point_diff=>-231.5, :ppg=>81.475, :papg=>84.36875, :ppg_diff=>-2.8937500000000114, :wp=>0.4}, "Drew M"=>{:wins=>44, :losses=>35, :ties=>0, :points_for=>6764.5, :points_against=>6856.5, :point_diff=>-92.0, :ppg=>85.62658227848101, :papg=>86.79113924050633, :ppg_diff=>-1.1645569620253156, :wp=>0.5569620253164557}, "Sean S"=>{:wins=>37, :losses=>25, :ties=>0, :points_for=>5463.0, :points_against=>5018.0, :point_diff=>445.0, :ppg=>88.11290322580645, :papg=>80.93548387096774, :ppg_diff=>7.177419354838705, :wp=>0.5967741935483871}, "Ryan D"=>{:wins=>11, :losses=>4, :ties=>0, :points_for=>1519.5, :points_against=>1292.5, :point_diff=>227.0, :ppg=>101.3, :papg=>86.16666666666667, :ppg_diff=>15.133333333333326, :wp=>0.7333333333333333}, "Nick D"=>{:wins=>39, :losses=>38, :ties=>1, :points_for=>6434.0, :points_against=>6554.0, :point_diff=>-120.0, :ppg=>82.48717948717949, :papg=>84.02564102564102, :ppg_diff=>-1.538461538461533, :wp=>0.5}, "Kyle P"=>{:wins=>39, :losses=>41, :ties=>0, :points_for=>6941.0, :points_against=>6976.5, :point_diff=>-35.5, :ppg=>86.7625, :papg=>87.20625, :ppg_diff=>-0.4437499999999943, :wp=>0.4875}, "Isaac S"=>{:wins=>38, :losses=>41, :ties=>0, :points_for=>6905.5, :points_against=>7050.5, :point_diff=>-145.0, :ppg=>87.4113924050633, :papg=>89.24683544303798, :ppg_diff=>-1.8354430379746844, :wp=>0.4810126582278481}, "Brad L"=>{:wins=>35, :losses=>44, :ties=>0, :points_for=>6749.5, :points_against=>7113.0, :point_diff=>-363.5, :ppg=>85.4367088607595, :papg=>90.0379746835443, :ppg_diff=>-4.601265822784811, :wp=>0.4430379746835443}, "Brian K"=>{:wins=>34, :losses=>46, :ties=>0, :points_for=>6779.5, :points_against=>6885.0, :point_diff=>-105.5, :ppg=>84.74375, :papg=>86.0625, :ppg_diff=>-1.3187499999999943, :wp=>0.425}, "Matt M"=>{:wins=>42, :losses=>37, :ties=>0, :points_for=>6839.0, :points_against=>6691.0, :point_diff=>148.0, :ppg=>86.56962025316456, :papg=>84.69620253164557, :ppg_diff=>1.8734177215189902, :wp=>0.5316455696202531}}

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


  def sort_owners_by(game_type)
    stats_hash = {}
    owners.each do |owner|
      stats_hash[owner.full_name] = owner.owner_stats(game_type)
    end
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
