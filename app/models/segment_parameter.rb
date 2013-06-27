class SegmentParameter < ActiveRecord::Base
  attr_accessible :value, :configuration_parameter_id

  belongs_to :segment
  belongs_to :configuration_parameter

  delegate :quality?, :quantity?, :min_value, :max_value, :weight, :set_min_and_max_value, :title,
    :to => :configuration_parameter
end
