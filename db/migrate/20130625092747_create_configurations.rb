class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.references :mine
      t.string :title

      t.timestamps
    end
    add_index :configurations, :mine_id
  end
end
