class QualityGroupingValue < ActiveRecord::Base
  belongs_to :grouping_parameter
  attr_accessible :title, :values
  serialize :values, Array

  has_many :segments, :as => :grouping_value

  before_save :compact_values

  private

  def compact_values
    self.values.delete_if {|v| v.blank?}
  end
end
