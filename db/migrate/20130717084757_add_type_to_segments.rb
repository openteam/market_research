class AddTypeToSegments < ActiveRecord::Migration
  def change
    add_column :segments, :type, :string
  end
end
