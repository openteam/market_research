class CreateConfigurationSegmentParameters < ActiveRecord::Migration
  def change
    create_table :configuration_segment_parameters do |t|
      t.references :configuration_segment
      t.references :configuration_parameter
      t.integer :quantity_value
      t.text :quality_value

      t.timestamps
    end
    add_index :configuration_segment_parameters, [:configuration_segment_id], :name => :conf_seg_par_id
    add_index :configuration_segment_parameters, [:configuration_parameter_id], :name => :conf_seg_par_conf_par_id
  end
end
