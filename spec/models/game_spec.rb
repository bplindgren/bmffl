require_relative '../rails_helper'

RSpec.describe Game, :type => :model do
  let!(:league) { League.create!(name: "BMFFL") }
  let!(:season) { Season.create!(year: 2011, league_id: league.id) }
  let!(:owner1) { Owner.create!(first_name: "Brian", last_name: "D") }
  let!(:owner2) { Owner.create!(first_name: "Nick", last_name: "D") }
  let!(:home_team) { Team.create!(season_id: season.id, name: "Iowa HerkysHeroes47", owner_id: owner1.id, division: "Upstairs") }
  let!(:away_team) { Team.create(season_id: season.id, name: "Westside Whales", owner_id: owner2.id, division: "Downstairs") }
  let!(:game) { Game.create!(season_id: season.id, week: 1, away_team_id: away_team.id, away_score: 100, home_team_id: home_team.id, home_score: 106.5, game_type: "Regular Season") }

  context 'point_differential method' do
    it 'tests the first game' do
      expect(Game.first.point_differential).to eq(6.5)
    end

    it 'correctly determines the winner' do
      expect(Game.first.winner.owner).to eq(owner1)
    end

    it 'correctly determines the loser' do
      expect(Game.first.loser.owner).to eq(owner2)
    end
  end

end
