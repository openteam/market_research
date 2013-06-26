# encoding: utf-8

class Item < ActiveRecord::Base
  attr_accessible :data

  belongs_to :mine

  has_many :item_segments, :dependent => :destroy
  has_many :segments, :through => :item_segments

  serialize :data, OpenStruct

  def dist_from(segment)
    dist = 0
    segment.parameters.each do |parameter|
      dist += 1.0 * parameter.weight if parameter.quality? && data.send(parameter.field_title) != parameter.value
      dist += (data.send(parameter.field_title).to_f - parameter.value.to_f).abs / (parameter.max_value - parameter.min_value) if parameter.quantity?
    end

    dist
  end
end
