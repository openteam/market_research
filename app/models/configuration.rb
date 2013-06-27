class Configuration < ActiveRecord::Base
  attr_accessible :title, :configuration_parameters_attributes

  belongs_to :mine

  has_many :configuration_parameters, :dependent => :destroy
  has_many :items,                    :through => :mine

  has_many :segments,           :dependent => :destroy
  has_many :segment_parameters, :through => :segments
  has_many :item_segments,      :through => :segments

  accepts_nested_attributes_for :configuration_parameters

  def calc
    set_min_and_max_values_for_quantity_parameters
    delete_item_segments

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

  def set_min_and_max_values_for_quantity_parameters
    segment_parameters.each(&:set_min_and_max_value)
  end

  def delete_item_segments
    segments.each { |segment| segment.item_segments.destroy_all }
  end
end
