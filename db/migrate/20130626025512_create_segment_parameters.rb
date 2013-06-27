class CreateSegmentParameters < ActiveRecord::Migration
  def change
    create_table :segment_parameters do |t|
      t.references :segment
      t.references :configuration_parameter
      t.string :value

      t.timestamps
    end
    add_index :segment_parameters, :segment_id
    add_index :segment_parameters, :configuration_parameter_id
  end
end
