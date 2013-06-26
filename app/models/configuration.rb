class Configuration < ActiveRecord::Base
  attr_accessible :title, :fields_attributes

  belongs_to :mine

  has_many :fields,     :dependent => :destroy
  has_many :items,      :through => :mine
  has_many :segments,   :dependent => :destroy
  has_many :parameters, :through => :segments

  accepts_nested_attributes_for :fields

  def calc
    set_min_and_max_values_for_fields

    items.each do |item|
      closest_segment = segments.first
      min_dist = item.dist_from(closest_segment)

      segments[1..-1].each do |segment|
        dist = item.dist_from(segment)
        if dist < min_dist
          min_dist = dist
          closest_segment = segment
        end
      end

      closest_segment.item_segments.create :item_id => item.id, :distance => min_dist
    end
  end

  private

  def set_min_and_max_values_for_fields
    parameters.each(&:set_min_and_max_value)
  end
end
