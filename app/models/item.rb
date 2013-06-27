# encoding: utf-8

class Item < ActiveRecord::Base
  attr_accessible :data

  belongs_to :mine

  has_many :item_segments, :dependent => :destroy
  has_many :segments,      :through => :item_segments

  serialize :data, OpenStruct

  def dist_from(segment)
    dist = 0
    k = segment.segment_parameters.map(&:weight).sum.to_f / segment.segment_parameters.count.to_f

    segment.segment_parameters.each do |segment_parameter|
      dist += 1.0 * segment_parameter.weight * k if segment_parameter.quality? && data.send(segment_parameter.title) != segment_parameter.value
      dist += (data.send(segment_parameter.title).to_f - segment_parameter.value.to_f).abs / (segment_parameter.max_value - segment_parameter.min_value) * segment_parameter.weight * k if segment_parameter.quantity?
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
