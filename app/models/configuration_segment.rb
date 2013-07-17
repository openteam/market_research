class ConfigurationSegment < Segment
  attr_accessible :title, :segment_parameters_attributes

  def initialize_segment_parameters
    configuration.configuration_parameters.each { |configuration_parameter| segment_parameters.build :configuration_parameter_id => configuration_parameter.id }
  end
end

