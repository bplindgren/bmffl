class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :game_id, { null: false }
      t.integer :team_id, { null: false }
      t.integer :voter_id, { null: false }

      t.timestamps null: false
    end
  end
end
