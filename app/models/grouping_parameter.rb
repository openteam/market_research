class GroupingParameter < ActiveRecord::Base
  extend Enumerize
  attr_accessible :title, :kind, :quality_grouping_values_attributes, :quantity_grouping_values_attributes

  belongs_to :grouping

  enumerize :kind, :in => [:quality, :quantity], :predicates => true

  has_many :quality_grouping_values, :dependent => :destroy, :order => 'quality_grouping_values.id ASC'
  accepts_nested_attributes_for :quality_grouping_values, :allow_destroy => true

  has_many :quantity_grouping_values, :dependent => :destroy, :order => 'quantity_grouping_values.id ASC'
  accepts_nested_attributes_for :quantity_grouping_values, :allow_destroy => true

  def grouping_values
    send "#{kind}_grouping_values"
  end
end
