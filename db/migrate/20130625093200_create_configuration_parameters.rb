class CreateConfigurationParameters < ActiveRecord::Migration
  def change
    create_table :configuration_parameters do |t|
      t.references :configuration
      t.string :title
      t.string :kind
      t.integer :weight

      t.timestamps
    end
    add_index :configuration_parameters, :configuration_id
  end
end
