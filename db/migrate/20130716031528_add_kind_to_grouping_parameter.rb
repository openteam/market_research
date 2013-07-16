class AddKindToGroupingParameter < ActiveRecord::Migration
  def change
    add_column :grouping_parameters, :kind, :string
  end
end
