class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.references :segment
      t.references :field
      t.string :value

      t.timestamps
    end
    add_index :parameters, :segment_id
    add_index :parameters, :field_id
  end
end
