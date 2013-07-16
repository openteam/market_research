class AddValueAndAncestryToSegment < ActiveRecord::Migration
  def self.up
    change_table :segments do |t|
      t.string :ancestry
      t.references :grouping_value, :polymorphic => true
    end
  end

  def self.down
    change_table :segments do |t|
      t.remove :ancestry
      t.remove_references :grouping_value, :polymorphic => true
    end
  end
end
