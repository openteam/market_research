class SegmentsController < ApplicationController
  inherit_resources

  belongs_to :mine, :configuration

  def new
    new! { @segment.initialize_parameters }
  end

  #def create
    #raise params.inspect
  #end
end
