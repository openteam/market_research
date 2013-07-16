# encoding: utf-8

class Grouping < ActiveRecord::Base
  attr_accessible :title, :grouping_parameters_attributes

  belongs_to :mine

  has_many :grouping_parameters, :dependent => :destroy, :order => 'grouping_parameters.id ASC'

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true

  def rebuild_segments
    Segment.roots.where(:grouping_value_id => grouping_parameters.map(&:grouping_values).flatten).destroy_all
    recalculate_segments
  end

  def recalculate_segments(previous_segment = nil, grouping_parameter = nil, level = 0)
    grouping_parameter ||= grouping_parameters.first
    grouping_parameter.grouping_values.each do |value|
      segment_title = previous_segment ? previous_segment.title + " #{value.title}" : value.title
      segment = Segment.create! :title => segment_title, :grouping_value => value, :parent => previous_segment
      recalculate_segments(segment, grouping_parameters[level+1], level+1) if level+1 < grouping_parameters.count
    end
  end

end
