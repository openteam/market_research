class Segment < ActiveRecord::Base
  attr_accessible :title, :grouping_value, :parent, :grouping #, :segment_parameters_attributes
  has_ancestry
  belongs_to :grouping_value, :polymorphic => true

  #belongs_to :configuration
  belongs_to :grouping

  has_many :item_segments,      :dependent => :destroy
  has_many :items,              :through => :item_segments
  #has_many :segment_parameters, :dependent => :destroy

  #accepts_nested_attributes_for :segment_parameters, :allow_destroy => true

  #def initialize_segment_parameters
    #configuration.configuration_parameters.each { |configuration_parameter| segment_parameters.build :configuration_parameter_id => configuration_parameter.id }
  #end

  after_create :associate_items

  private

  def associate_items
    (parent || grouping_value.grouping_parameter.grouping.mine).items.each do |item|
      item_parameter_value = item.data[grouping_value.grouping_parameter.title]
      case grouping_value.class.name
      when  "QualityGroupingValue"
        item_segments.create(item: item) if grouping_value.values.include?(item_parameter_value)
      when "QuantityGroupingValue"
        item_parameter_value = item_parameter_value.to_i
        item_segments.create(item: item) if item_parameter_value >= grouping_value.min_count && item_parameter_value <= grouping_value.max_count
      end
    end

  end

end
