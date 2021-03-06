require 'rails_helper'

RSpec.describe Team, :type => :model do
  let!(:league) { League.create!(name: "BMFFL") }
  let!(:season) { Season.create!(year: 2011, league_id: league.id, completed?: true) }

  let!(:owner1) { Owner.create!(first_name: "Brad", last_name: "L") }
  let!(:team1) { Team.create!(season_id: season.id, name: "The Ricky Stanzis", abbr: "RS", owner_id: owner1.id, division: "Upstairs") }

  let!(:owner2) { Owner.create!(first_name: "Isaac", last_name: "S") }
  let!(:team2) { Team.create!(season_id: season.id, name: "The Belt", abbr: "BELT", owner_id: owner2.id, division: "Downstairs") }

  let!(:owner3) { Owner.create!(first_name: "Dan", last_name: "O") }
  let!(:team3) { Team.create!(season_id: season.id, name: "Balls Tech", abbr: "BT", owner_id: owner3.id, division: "Upstairs") }

  let!(:owner4) { Owner.create!(first_name: "Brian", last_name: "D") }
  let!(:team4) { Team.create!(season_id: season.id, name: "Iowa HerkysHeroes47", abbr: "IHH47", owner_id: owner4.id, division: "Upstairs") }

  let!(:game1) { Game.create!(season_id: season.id, week: 5, away_team_id: team2.id, away_score: 77, home_team_id: team1.id, home_score: 84, completed?: true, game_type: "Regular Season") }
  let!(:game2) { Game.create!(season_id: season.id, week: 8, away_team_id: team3.id, away_score: 67.5, home_team_id: team1.id, home_score: 89, completed?: true, game_type: "Regular Season") }
  let!(:game3) { Game.create!(season_id: season.id, week: 12, away_team_id: team4.id, away_score: 95.5, home_team_id: team1.id, home_score: 49, completed?: true, game_type: "Regular Season") }

  context 'gets team info' do
    it 'tests team_stats method' do
      expect(team1.team_stats("All")).to eq( {:wins => 2, :losses => 1, :ties => 0, :points_for => 222.0, :points_against => 240.0, :point_diff => -18.0, :ppg => 74.0, :papg => 80.0, :ppg_diff => -6.0, :wp => 0.6666666666666666 } )
    end

    it 'tests the over_500 method' do
      expect(team1.over_500("All")).to eq(1)
    end
  end
end
