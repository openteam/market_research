class GroupingsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine

  custom_actions :resource => :segments

  def segments
  end
end
