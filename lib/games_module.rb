module Games
  def games
    home_games + away_games
  end

  def games_by_type(game_type)
    case game_type
    when "All"
      games.select { |game| game.home_score > 0 }
    when "Regular Season"
      games.select { |game| game.game_type == "Regular Season" && game.home_score > 0 }
    when "Playoffs"
      games.select { |game| game.game_type != "Regular Season" && game.game_type != "Consolation Game" && game.home_score > 0 }
    when "Regular Season & Playoffs"
      games.select { |game| game.game_type != "Consolation Game" && game.home_score > 0 }
    when "Consolation Games"
      games.select { |game| game.game_type == "Consolation Game" && game.home_score > 0 }
    end
  end
end