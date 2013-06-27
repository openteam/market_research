class ChangeConfigurationParametersWeight < ActiveRecord::Migration
  def up
    change_column :configuration_parameters, :weight, :float
  end

  def down
    change_column :configuration_parameters, :weight, :integer
  end
end
