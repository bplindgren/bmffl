require 'games_module.rb'

class Owner < ApplicationRecord
  include Games
  has_many :teams
  has_many :home_games, through: :teams, source: :home_games
  has_many :away_games, through: :teams, source: :away_games
  has_many :seasons, through: :teams
  has_many :leagues, through: :seasons

  validates :first_name, :last_name, presence: true

  def owner_stats(game_type)
    games = games_by_type(game_type)
    stats = {:wins => 0, :losses => 0, :ties => 0, :point_diff => 0}

    games.each do |game|
      if game.winner == nil
        stats[:ties] += 1
        break if game == "tie"
      elsif game.winner.owner_id == self.id
        stats[:wins] += 1
        stats[:point_diff] += game.point_differential
      elsif game.loser.owner_id == self.id
        stats[:losses] += 1
        stats[:point_diff] -= game.point_differential
      end
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

  # def vs(opponent, game_type)
  #   opponent = Owner.find(opponent)
  #   opponent_teams = opponent.teams
  #   team_ids = []
  #   opponent_teams.each do |team|
  #     team_ids << team.id
  #   end
  # end
end
