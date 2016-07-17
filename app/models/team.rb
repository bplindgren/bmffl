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
    stats = {:wins => 0, :losses => 0, :ties => 0, :point_diff => 0}

    games.each do |game|
      if game.winner == nil
        stats[:ties] += 1
        break if game == "tie"
      elsif game.winner.owner_id == owner.id
        stats[:wins] += 1
        stats[:point_diff] += game.point_differential
      elsif game.loser.owner_id == owner.id
        stats[:losses] += 1
        stats[:point_diff] -= game.point_differential
      end
    end
    stats
  end

  def over_500(game_type)
    ts = team_stats(game_type)
    ts[:wins] - ts[:losses]
  end
end
