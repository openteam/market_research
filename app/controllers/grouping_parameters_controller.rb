class GroupingParametersController < ApplicationController
  inherit_resources

  actions :edit, :update

  belongs_to :mine, :grouping
end
