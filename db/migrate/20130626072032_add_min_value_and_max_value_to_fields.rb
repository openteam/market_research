class AddMinValueAndMaxValueToFields < ActiveRecord::Migration
  def change
    add_column :fields, :min_value, :float
    add_column :fields, :max_value, :float
  end
end
