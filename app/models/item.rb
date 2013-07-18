# encoding: utf-8

class Item < ActiveRecord::Base
  attr_accessible :data

  belongs_to :mine

  has_many :item_segments, :dependent => :destroy
  has_many :segments,      :through => :item_segments

  serialize :data, OpenStruct

  def dist_from(segment)
    dist = 0
    k = segment.configuration_segment_parameters.map(&:weight).sum.to_f / segment.configuration_segment_parameters.count.to_f

    segment.configuration_segment_parameters.each do |segment_parameter|
      if segment_parameter.quality?
        dist += segment_parameter.quality_value.include?(data[segment_parameter.title]) ? 0 : 1.0 * segment_parameter.weight * k
      else
        dist += (data.send(segment_parameter.title).to_f - segment_parameter.quantity_value.to_f).abs / (segment_parameter.max_value - segment_parameter.min_value) * segment_parameter.weight * k
      end
    end

    dist
  end

  def self.cached_all_items
    @cached_all_items ||= all
  end

  def self.with(conditions)
    all_items = cached_all_items

    conditions.each do |field, value|
      all_items = all_items.select { |item| item.data[field] == value }
    end

    all_items
  end
end
