class ConfigurationsController < ApplicationController
  inherit_resources

  belongs_to :mine

  custom_actions :resource => :calc

  def calc
    calc! {
      @configuration.calc
      redirect_to [@mine, @configuration] and return
    }
  end
end
