class SegmentsController < ApplicationController
  inherit_resources

  actions :all, :except => :index

  belongs_to :mine, :configuration

  def new
    new! { @segment.initialize_segment_parameters }
  end
end
