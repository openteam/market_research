class QuantityGroupingValue < ActiveRecord::Base
  belongs_to :grouping_parameter
  attr_accessible :max_count, :min_count, :title

  has_many :segments, :as => :grouping_value
end
