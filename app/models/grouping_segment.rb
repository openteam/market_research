require 'segment'

class GroupingSegment < Segment
  attr_accessible :title, :grouping_value, :parent, :grouping

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