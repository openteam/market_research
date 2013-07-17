class GroupingsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine

  custom_actions :resource => [:grouping_segments, :rebuild]

  def segments
  end

  def rebuild
    resource.rebuild_segments
    redirect_to grouping_segments_resource_path
  end
end
