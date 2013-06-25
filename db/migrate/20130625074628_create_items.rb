class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :data

      t.timestamps
    end
  end
end
