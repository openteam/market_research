class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.references :configuration
      t.string :title

      t.timestamps
    end
    add_index :segments, :configuration_id
  end
end
