class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :season_id, { null: false }
      t.integer :week, { null: false }
      t.integer :away_team_id, { null: false }
      t.float :away_score
      t.integer :home_team_id, { null: false }
      t.float :home_score
      t.string :game_type, { null: false }

      t.timestamps
    end
    add_index :games, :away_team_id
    add_index :games, :home_team_id
  end
end
