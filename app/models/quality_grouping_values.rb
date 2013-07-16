class QualityGroupingValues < ActiveRecord::Base
  belongs_to :grouping_parameter
  attr_accessible :title, :values
end
