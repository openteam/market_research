class GroupingSegmentsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine do
    belongs_to :grouping, :optional => true
  end
end

