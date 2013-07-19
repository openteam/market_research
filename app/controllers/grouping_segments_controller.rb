class GroupingSegmentsController < ApplicationController
  inherit_resources

  actions :all, :only => [:show]

  belongs_to :mine do
    belongs_to :grouping
  end

  protected
  def collection
    @segments ||= GroupingSegment.roots.where(:grouping_id => parent.id).order(:title)
  end

end

