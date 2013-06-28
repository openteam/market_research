class GroupingsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine
end
