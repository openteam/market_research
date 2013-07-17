class ConfigurationSegmentsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine do
    belongs_to :configuration, :optional => true
  end

  def new
    new! { @configuration_segment.initialize_segment_parameters }
  end
end

