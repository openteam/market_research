class Segment < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :grouping_value, :parent, :grouping, :configuration_segment_parameters_attributes
  belongs_to :grouping_value, :polymorphic => true

  belongs_to :configuration
  belongs_to :grouping

  has_many :item_segments,      :dependent => :destroy
  has_many :items,              :through => :item_segments
  has_many :configuration_segment_parameters, :dependent => :destroy

  accepts_nested_attributes_for :configuration_segment_parameters, :allow_destroy => true
end
