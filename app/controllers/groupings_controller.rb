class GroupingsController < ApplicationController
  inherit_resources

  actions :all

  belongs_to :mine

  custom_actions :resource => :data

  def data
    data! { render :json => @grouping.bar and return }
  end
end
