class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :configuration
      t.string :title
      t.string :kind
      t.integer :weight

      t.timestamps
    end
    add_index :fields, :configuration_id
  end
end
