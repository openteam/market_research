class ChangeFieldWeight < ActiveRecord::Migration
  def up
    change_column :fields, :weight, :float
  end

  def down
    change_column :fields, :weight, :integer
  end
end
