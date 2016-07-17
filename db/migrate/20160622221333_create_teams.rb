class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :season_id, { null: false }
      t.string :name, { null: false }
      t.string :abbr, { null: false }
      t.integer :owner_id, { null: false }
      t.string :division, { null: false }

      t.timestamps null: false
    end
    add_index :teams, :season_id
    add_index :teams, :owner_id
  end
end
