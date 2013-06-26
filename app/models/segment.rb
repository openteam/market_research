class Segment < ActiveRecord::Base
  attr_accessible :title, :parameters_attributes

  belongs_to :configuration

  has_many :parameters, :dependent => :destroy

  accepts_nested_attributes_for :parameters

  def initialize_parameters
    configuration.fields.each { |field| parameters.build :field_id => field.id }
  end
end
