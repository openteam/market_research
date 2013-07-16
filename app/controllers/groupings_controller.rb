class GroupingsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine

  custom_actions :resource => [:segments, :rebuild]

  def segments
  end

  def rebuild
    resource.rebuild_segments
    redirect_to segments_resource_path
  end
end
