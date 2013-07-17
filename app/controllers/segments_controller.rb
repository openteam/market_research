class SegmentsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine do
    belongs_to :configuration, :optional => true
    belongs_to :grouping, :optional => true
  end

  def new
    new! { @segment.initialize_segment_parameters }
  end
end
