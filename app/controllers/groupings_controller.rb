class GroupingsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine

  custom_actions :resource => [:rebuild]

  def rebuild
    resource.rebuild_segments
    redirect_to mine_grouping_grouping_segments_path(parent, resource)
  end
end
