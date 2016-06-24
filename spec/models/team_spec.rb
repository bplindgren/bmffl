require 'rails_helper'

RSpec.describe Team, :type => :model do
  let!(:league) { League.create!(name: "BMFFL") }
  let!(:season) { Season.create!(year: 2011, league_id: league.id) }

  let!(:owner1) { Owner.create!(first_name: "Brad", last_name: "L") }
  let!(:team1) { Team.create!(season_id: season.id, name: "The Ricky Stanzis", owner_id: owner1.id, division: "Upstairs") }

  let!(:owner2) { Owner.create!(first_name: "Isaac", last_name: "S") }
  let!(:team2) { Team.create!(season_id: season.id, name: "The Belt", owner_id: owner2.id, division: "Downstairs") }

  let!(:owner3) { Owner.create!(first_name: "Dan", last_name: "O") }
  let!(:team3) { Team.create!(season_id: season.id, name: "Balls Tech", owner_id: owner3.id, division: "Upstairs") }

  let!(:owner4) { Owner.create!(first_name: "Brian", last_name: "D") }
  let!(:team4) { Team.create!(season_id: season.id, name: "Iowa HerkysHeroes47", owner_id: owner4.id, division: "Upstairs") }

  let!(:game1) { Game.create!(season_id: season.id, week: 5, away_team_id: owner2.id, away_score: 77, home_team_id: owner1.id, home_score: 84, game_type: "Regular Season") }
  let!(:game2) { Game.create!(season_id: season.id, week: 8, away_team_id: owner3.id, away_score: 67.5, home_team_id: owner1.id, home_score: 89, game_type: "Regular Season") }
  let!(:game3) { Game.create!(season_id: season.id, week: 12, away_team_id: owner4.id, away_score: 95.5, home_team_id: owner1.id, home_score: 49, game_type: "Regular Season") }

  context 'gets team info' do
    it 'tests team_stats method' do
      expect(team1.team_stats("All")).to eq( {:wins => 2, :losses => 1, :ties => 0, :point_diff => -18 } )
    end

    it 'tests the over_500 method' do
      expect(team1.over_500("All")).to eq(1)
    end
  end
end
