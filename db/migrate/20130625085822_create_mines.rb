class CreateMines < ActiveRecord::Migration
  def change
    create_table :mines do |t|

      t.timestamps
    end
  end
end
