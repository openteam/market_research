class QualityGroupingValue < ActiveRecord::Base
  belongs_to :grouping_parameter
  attr_accessible :title, :values
  serialize :values, Array
end
