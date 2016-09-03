require 'games_module.rb'

class Owner < ApplicationRecord
  include Games
  has_many :teams
  has_many :home_games, through: :teams, source: :home_games
  has_many :away_games, through: :teams, source: :away_games
  has_many :seasons, through: :teams
  has_many :leagues, through: :seasons

  validates :first_name, :last_name, presence: true

  def full_name
    first_name + ' ' + last_name
  end

  def owner_stats(game_type)
    games = games_by_type(game_type)
    stats = {:games_played => 0, :wins => 0, :losses => 0, :ties => 0, :points_for => 0, :points_against => 0, :point_diff => 0, :ppg => 0, :papg => 0, :ppg_diff => 0, :wp => 0.000}

    games.each do |game|
      stats[:games_played] += 1
      scores = [game.home_score, game.away_score].sort.reverse
      if game.winner == nil
        stats[:ties] += 1
        break if game == "tie"
      elsif game.winner.owner_id == self.id
        stats[:wins] += 1
        stats[:points_for] += scores[0]
        stats[:points_against] += scores[1]
      elsif game.loser.owner_id == self.id
        stats[:losses] += 1
        stats[:points_for] += scores[1]
        stats[:points_against] += scores[0]
      end
      stats[:point_diff] = (stats[:points_for] - stats[:points_against]).round(2)
      stats[:ppg] = (stats[:points_for] / games.count).round(2)
      stats[:papg] = (stats[:points_against] / games.count).round(2)
      stats[:ppg_diff] = (stats[:ppg] - stats[:papg]).round(2)
      stats[:wp] = (stats[:wins].to_f / games.count).round(3)
    end
    stats
  end

  def over_500(game_type)
    os = owner_stats(game_type)
    os[:wins] - os[:losses]
  end

  def over_500_by_season(game_type)
    season_records = []
    teams.each { |team| season_records << team.over_500(game_type) }
    season_records
  end

end
