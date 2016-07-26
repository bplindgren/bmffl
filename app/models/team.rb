require 'games_module.rb'

class Team < ApplicationRecord
  include Games
  belongs_to :owner
  belongs_to :season
  has_many :leagues, through: :season
  has_many :away_games, foreign_key: :away_team_id, class_name: 'Game'
  has_many :home_games, foreign_key: :home_team_id, class_name: 'Game'

  validates :season_id, :name, :abbr, :owner_id, :division, presence: true

  def team_stats(game_type)
    games = games_by_type(game_type)
    stats = {:wins => 0, :losses => 0, :ties => 0, :points_for => 0, :points_against => 0, :point_diff => 0, :ppg => 0, :papg => 0, :ppg_diff => 0, :wp => 0.000}

    games.each do |game|
      scores = [game.home_score, game.away_score].sort.reverse
      if game.winner == nil
        stats[:ties] += 1
        break if game == "tie"
      elsif game.winner.owner_id == self.owner.id
        stats[:wins] += 1
        stats[:points_for] += scores[0]
        stats[:points_against] += scores[1]
      elsif game.loser.owner_id == self.owner.id
        stats[:losses] += 1
        stats[:points_for] += scores[1]
        stats[:points_against] += scores[0]
      end
      stats[:point_diff] = stats[:points_for] - stats[:points_against]
      stats[:ppg] = stats[:points_for] / games.count
      stats[:papg] = stats[:points_against] / games.count
      stats[:ppg_diff] = stats[:ppg] - stats[:papg]
      stats[:wp] = stats[:wins].to_f / games.count
    end
    stats
  end

  def over_500(game_type)
    ts = team_stats(game_type)
    ts[:wins] - ts[:losses]
  end
end
