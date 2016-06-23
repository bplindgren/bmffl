module Games
  def games
    home_games + away_games
  end

  def games_by_type(game_type)
    case game_type
    when "All"
      games
    when "Regular Season"
      games.select { |game| game.game_type == "Regular Season" }
    when "Playoffs"
      games.select { |game| game.game_type != "Regular Season" && game.game_type != "Consolation Game" }
    when "Regular Season & Playoffs"
      games.select { |game| game.game_type != "Consolation Game" }
    when "Consolation Games"
      games.select { |game| game.game_type == "Consolation Game" }
    end
  end
end