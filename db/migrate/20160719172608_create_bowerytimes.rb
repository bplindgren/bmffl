class CreateBowerytimes < ActiveRecord::Migration[5.0]
  def change
    create_table :bowerytimes do |t|

      t.timestamps
    end
  end
end
