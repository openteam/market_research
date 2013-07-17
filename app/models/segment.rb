class Segment < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :grouping_value, :parent, :grouping, :segment_parameters_attributes
  belongs_to :grouping_value, :polymorphic => true

  belongs_to :configuration
  belongs_to :grouping

  has_many :item_segments,      :dependent => :destroy
  has_many :items,              :through => :item_segments
  has_many :segment_parameters, :dependent => :destroy

  accepts_nested_attributes_for :segment_parameters, :allow_destroy => true
end
