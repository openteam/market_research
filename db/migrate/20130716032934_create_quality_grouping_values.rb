class CreateQualityGroupingValues < ActiveRecord::Migration
  def change
    create_table :quality_grouping_values do |t|
      t.string :title
      t.text :values
      t.references :grouping_parameter

      t.timestamps
    end
    add_index :quality_grouping_values, :grouping_parameter_id
  end
end
