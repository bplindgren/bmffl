require 'rails_helper'

RSpec.describe Owner, :type => :model do
  let!(:league) { League.create!(name: "BMFFL") }
  let!(:season1) { Season.create!(year: 2011, league_id: league.id, completed?: true) }
  let!(:season2) { Season.create!(year: 2012, league_id: league.id, completed?: true) }

  let!(:owner1) { Owner.create!(first_name: "Brad", last_name: "L") }
  let!(:owner2) { Owner.create!(first_name: "Isaac", last_name: "S") }
  let!(:owner3) { Owner.create!(first_name: "Dan", last_name: "O") }
  let!(:owner4) { Owner.create!(first_name: "Brian", last_name: "D") }
  let!(:owner5) { Owner.create!(first_name: "Nick", last_name: "D") }

  let!(:team1) { Team.create!(season_id: season1.id, name: "The Ricky Stanzis", abbr: "RS", owner_id: owner1.id, division: "Upstairs") }
  let!(:team2) { Team.create!(season_id: season1.id, name: "The Belt", abbr: "BELT", owner_id: owner2.id, division: "Downstairs") }
  let!(:team3) { Team.create!(season_id: season1.id, name: "Balls Tech", abbr: "BT", owner_id: owner3.id, division: "Upstairs") }
  let!(:team4) { Team.create!(season_id: season1.id, name: "Iowa HerkysHeroes47", abbr: "IHH47", owner_id: owner4.id, division: "Upstairs") }
  let!(:team5) { Team.create!(season_id: season2.id, name: "The Ricky Stanzis", abbr: "RS", owner_id: owner1.id, division: "Upstairs") }
  let!(:team6) { Team.create!(season_id: season2.id, name: "Westside Whales", abbr: "WW", owner_id: owner5.id, division: "Downstairs") }
  let!(:team7) { Team.create!(season_id: season2.id, name: "Balls Tech", abbr: "BT", owner_id: owner3.id, division: "Upstairs") }
  let!(:team8) { Team.create!(season_id: season2.id, name: "Iowa HerkysHeroes47", abbr: "IHH47", owner_id: owner4.id, division: "Upstairs") }

  let!(:game1) { Game.create!(season_id: season1.id, week: 5, away_team_id: team2.id, away_score: 77, home_team_id: team1.id, home_score: 84, game_type: "Regular Season") }
  let!(:game2) { Game.create!(season_id: season1.id, week: 8, away_team_id: team3.id, away_score: 67.5, home_team_id: team1.id, home_score: 89, game_type: "Regular Season") }
  let!(:game3) { Game.create!(season_id: season1.id, week: 12, away_team_id: team4.id, away_score: 95.5, home_team_id: team1.id, home_score: 49, game_type: "Regular Season") }
  let!(:game4) { Game.create!(season_id: season2.id, week: 1, away_team_id: team5.id, away_score: 71, home_team_id: team6.id, home_score: 67.5, game_type: "Regular Season") }
  let!(:game5) { Game.create!(season_id: season2.id, week: 4, away_team_id: team5.id, away_score: 87.5, home_team_id: team8.id, home_score: 110.5, game_type: "Regular Season") }
  let!(:game6) { Game.create!(season_id: season2.id, week: 5, away_team_id: team7.id, away_score: 46.5, home_team_id: team5.id, home_score: 93, game_type: "Regular Season") }

  context 'tests the owner model' do
    it 'tests the owner_stats method' do
      expect(owner1.owner_stats("All")).to eq( {:games_played => 6, :wins => 4, :losses => 2, :ties => 0, :points_against => 464.5, :points_for => 473.5, :point_diff => 9.0, :ppg => 78.92, :papg => 77.42, :ppg_diff => 1.5, :wp => 0.667 } )
    end

    it 'tests the over_500 method' do
      expect(owner1.over_500("All")).to eq (2)
      expect(owner2.over_500("All")).to eq (-1)
    end

    it 'tests the over_500_by_season' do
      expect(owner1.over_500_by_season("All")).to eq([1,1])
    end
  end
end
