require 'rails_helper'

RSpec.describe League, :type => :model do
  let!(:league) { League.create!(name: "BMFFL") }
  let!(:season1) { Season.create!(year: 2011, league_id: league.id) }
  let!(:season2) { Season.create!(year: 2012, league_id: league.id) }

  let!(:owner1) { Owner.create!(first_name: "Brad", last_name: "L") } # 6-2
  let!(:owner2) { Owner.create!(first_name: "Isaac", last_name: "S") } # 0-1
  let!(:owner3) { Owner.create!(first_name: "Dan", last_name: "O") } # 0-1
  let!(:owner4) { Owner.create!(first_name: "Brian", last_name: "D") } # 1-1
  let!(:owner5) { Owner.create!(first_name: "Nick", last_name: "D") } # 0-3

  let!(:team1) { Team.create!(season_id: season1.id, name: "The Ricky Stanzis", owner_id: owner1.id, division: "Upstairs") } # 2-1
  let!(:team2) { Team.create!(season_id: season1.id, name: "The Belt", owner_id: owner2.id, division: "Downstairs") } # 0-1
  let!(:team3) { Team.create!(season_id: season1.id, name: "Balls Tech", owner_id: owner3.id, division: "Upstairs") } # 0-1
  let!(:team4) { Team.create!(season_id: season1.id, name: "Iowa HerkysHeroes47", owner_id: owner4.id, division: "Upstairs") } # 1-0
  let!(:team5) { Team.create!(season_id: season2.id, name: "The Ricky Stanzis", owner_id: owner1.id, division: "Upstairs") } # 4-1
  let!(:team6) { Team.create!(season_id: season2.id, name: "Westside Whales", owner_id: owner5.id, division: "Downstairs") } # 0-3
  let!(:team7) { Team.create!(season_id: season2.id, name: "Balls Tech", owner_id: owner3.id, division: "Upstairs") } # 0-1
  let!(:team8) { Team.create!(season_id: season2.id, name: "Iowa HerkysHeroes47", owner_id: owner4.id, division: "Upstairs") } # 1-0

  let!(:game1) { Game.create!(season_id: season1.id, week: 5, away_team_id: team2.id, away_score: 77, home_team_id: team1.id, home_score: 84, game_type: "Regular Season") }
  let!(:game2) { Game.create!(season_id: season1.id, week: 8, away_team_id: team3.id, away_score: 67.5, home_team_id: team1.id, home_score: 89, game_type: "Regular Season") }
  let!(:game3) { Game.create!(season_id: season1.id, week: 12, away_team_id: team4.id, away_score: 95.5, home_team_id: team1.id, home_score: 49, game_type: "Regular Season") }
  let!(:game4) { Game.create!(season_id: season2.id, week: 1, away_team_id: team5.id, away_score: 71, home_team_id: team6.id, home_score: 67.5, game_type: "Regular Season") }
  let!(:game5) { Game.create!(season_id: season2.id, week: 4, away_team_id: team5.id, away_score: 87.5, home_team_id: team8.id, home_score: 110.5, game_type: "Regular Season") }
  let!(:game6) { Game.create!(season_id: season2.id, week: 5, away_team_id: team7.id, away_score: 46.5, home_team_id: team5.id, home_score: 91, game_type: "Regular Season") }
  let!(:game7) { Game.create!(season_id: season2.id, week: 7, away_team_id: team6.id, away_score: 36.5, home_team_id: team5.id, home_score: 88, game_type: "Regular Season") }
  let!(:game8) { Game.create!(season_id: season2.id, week: 8, away_team_id: team5.id, away_score: 96.5, home_team_id: team6.id, home_score: 88, game_type: "Regular Season") }

  context 'model' do
    it 'returns owner_season_records' do
      expect(league.owner_season_records("All")).to eq (
            { "Brad" => { 2011 => [2, 1], 2012 => [4, 1] },
              "Isaac" => { 2011 => [0, 1] },
              "Dan" => { 2011 => [0, 1], 2012 => [0, 1] },
              "Brian" => { 2011 => [1, 0], 2012 => [1, 0] },
              "Nick" => { 2012 => [0, 3] }
            }
          )
    end

    it 'returns the standings' do
      expect(league.standings("All")).to eq ([owner1, owner4, owner2, owner3, owner5])
    end

    it 'returns the average points per game' do
      expect(league.avg_ppg).to eq (77.8)
    end

    it 'returns the average point differential' do
      expect(league.avg_point_differential).to eq (25.8)
    end
  end
end
