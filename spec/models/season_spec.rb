require 'rails_helper'

RSpec.describe Season, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let!(:season) { Season.find(1) }

  context 'tests the season' do
    it 'finds the right champion' do
      expect(season.champion.first_name).to eq ("Kyle")
    end
  end

end
