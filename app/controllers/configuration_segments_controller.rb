class ConfigurationSegmentsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine do
    belongs_to :configuration, :optional => true
  end

  def new
    new! { @configuration_segment.initialize_segment_parameters }
  end

  def create
    create! {parent_url}
  end

  def update
    update! {parent_url}
  end
end

