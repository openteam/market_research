class ConfigurationSegmentParameter < ActiveRecord::Base
  attr_accessible :quality_value, :quantity_value, :configuration_parameter_id, :configuration_parameter
  serialize :quality_value, Array

  belongs_to :configuration_segment
  belongs_to :configuration_parameter

  delegate :quality?, :quantity?, :min_value, :max_value, :weight, :set_min_and_max_value, :title,
        :to => :configuration_parameter

  before_save :compact_quality_value

  def compact_quality_value
    self.quality_value.delete_if {|v| v.blank?} if self.quality_value?
  end
end
