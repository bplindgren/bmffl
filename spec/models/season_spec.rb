require 'rails_helper'

RSpec.describe Season, :type => :model do
  let!(:league) { League.create!(name: "BMFFL") }
  let!(:season) { Season.create!(year: 2011, league_id: league.id, completed?: true) }

  let!(:owner1) { Owner.create!(first_name: "Kyle", last_name: "P") }
  let!(:owner2) { Owner.create!(first_name: "Nick", last_name: "D") }
  let!(:owner3) { Owner.create!(first_name: "Brad", last_name: "L") }
  let!(:owner4) { Owner.create!(first_name: "Brian", last_name: "D") }

  let!(:team1) { Team.create!(season_id: season.id, name: "The Green Bay Belts", abbr: "GBB", owner_id: owner1.id, division: "Downstairs") }
  let!(:team2) { Team.create!(season_id: season.id, name: "Westside Whales", abbr: "WW", owner_id: owner2.id, division: "Downstairs") }
  let!(:team3) { Team.create!(season_id: season.id, name: "The Ricky Stanzis", abbr: "RS", owner_id: owner3.id, division: "Upstairs") }
  let!(:team4) { Team.create!(season_id: season.id, name: "Iowa HerkysHeroes47", abbr: "IHH47", owner_id: owner4.id, division: "Upstairs") }

  let!(:game1) { Game.create!(season_id: season.id, week: 16, away_team_id: team1.id, away_score: 99, home_team_id: team2.id, home_score: 86.5, completed?: true, game_type: "Super Bowl") }
  let!(:game2) { Game.create!(season_id: season.id, week: 12, away_team_id: team1.id, away_score: 109, home_team_id: team4.id, home_score: 86.5, completed?: true, game_type: "Regular Season") }
  let!(:game3) { Game.create!(season_id: season.id, week: 8, away_team_id: team4.id, away_score: 88, home_team_id: team3.id, home_score: 36, completed?: true, game_type: "Regular Season") }
  let!(:game4) { Game.create!(season_id: season.id, week: 3, away_team_id: team2.id, away_score: 105, home_team_id: team3.id, home_score: 56, completed?: true, game_type: "Regular Season") }
  let!(:game5) { Game.create!(season_id: season.id, week: 3, away_team_id: team1.id, away_score: 120, home_team_id: team4.id, home_score: 76, completed?: true, game_type: "Regular Season") }
  let!(:game6) { Game.create!(season_id: season.id, week: 3, away_team_id: team2.id, away_score: 111, home_team_id: team3.id, home_score: 88.5, completed?: true, game_type: "Regular Season") }

  context 'tests the season' do
    it 'calculates the overall standings' do
      expect(season.standings("All", season.teams)).to eq ([team1, team2, team4, team3])
    end

    it 'calculates the standings by division' do
      expect(season.division_standings("All")).to eq ({ :upstairs => [team4, team3], :downstairs => [team1, team2] })
    end

    it 'finds the right champion' do
      expect(season.champion.owner.first_name).to eq ("Kyle")
    end
  end
end
