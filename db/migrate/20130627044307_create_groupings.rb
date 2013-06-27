class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.string :title
      t.references :mine

      t.timestamps
    end
    add_index :groupings, :mine_id
  end
end
