class Segment < ActiveRecord::Base
  attr_accessible :title, :segment_parameters_attributes

  belongs_to :configuration

  has_many :item_segments,      :dependent => :destroy
  has_many :items,              :through => :item_segments
  has_many :segment_parameters, :dependent => :destroy

  accepts_nested_attributes_for :segment_parameters, :allow_destroy => true

  def initialize_segment_parameters
    configuration.configuration_parameters.each { |configuration_parameter| segment_parameters.build :configuration_parameter_id => configuration_parameter.id }
  end
end
