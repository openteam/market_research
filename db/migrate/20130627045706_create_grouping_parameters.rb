class CreateGroupingParameters < ActiveRecord::Migration
  def change
    create_table :grouping_parameters do |t|
      t.references :grouping
      t.string :title

      t.timestamps
    end
    add_index :grouping_parameters, :grouping_id
  end
end
