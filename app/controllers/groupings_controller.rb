class GroupingsController < ApplicationController
  inherit_resources

  actions :all, :except => [:index, :show]

  belongs_to :mine
end
