class Segment < ActiveRecord::Base
  attr_accessible :title, :parameters_attributes

  belongs_to :configuration

  has_many :item_segments, :dependent => :destroy
  has_many :items,         :through => :item_segments
  has_many :parameters,    :dependent => :destroy

  accepts_nested_attributes_for :parameters, :allow_destroy => true

  def initialize_parameters
    configuration.fields.each { |field| parameters.build :field_id => field.id }
  end
end
