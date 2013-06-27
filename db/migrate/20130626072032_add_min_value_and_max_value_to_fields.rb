class AddMinValueAndMaxValueToFields < ActiveRecord::Migration
  def change
    add_column :configuration_parameters, :min_value, :float
    add_column :configuration_parameters, :max_value, :float
  end
end
