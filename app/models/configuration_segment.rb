class ConfigurationSegment < Segment
  attr_accessible :title, :configuration_segment_parameters_attributes

  has_many :configuration_segment_parameters, :dependent => :destroy

  accepts_nested_attributes_for :configuration_segment_parameters

  def initialize_segment_parameters
    configuration.configuration_parameters.each do |configuration_parameter|
        configuration_segment_parameters.build :configuration_parameter => configuration_parameter
    end
  end
end

