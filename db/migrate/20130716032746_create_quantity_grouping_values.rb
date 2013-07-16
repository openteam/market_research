class CreateQuantityGroupingValues < ActiveRecord::Migration
  def change
    create_table :quantity_grouping_values do |t|
      t.string :title
      t.integer :min_count
      t.integer :max_count
      t.references :grouping_parameter

      t.timestamps
    end
    add_index :quantity_grouping_values, :grouping_parameter_id
  end
end
