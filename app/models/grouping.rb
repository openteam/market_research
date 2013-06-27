class Grouping < ActiveRecord::Base
  attr_accessible :title, :grouping_parameters_attributes

  belongs_to :mine

  has_many :grouping_parameters, :dependent => :destroy

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true
end
