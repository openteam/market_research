class AddGroupingIdToSegments < ActiveRecord::Migration
  def change
    add_column :segments, :grouping_id, :integer
    add_index :segments, :grouping_id
  end
end
