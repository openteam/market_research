class CreateItemSegments < ActiveRecord::Migration
  def change
    create_table :item_segments do |t|
      t.references :item
      t.references :segment
      t.float :distance

      t.timestamps
    end
    add_index :item_segments, :item_id
    add_index :item_segments, :segment_id
  end
end
