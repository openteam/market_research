class Configuration < ActiveRecord::Base
  belongs_to :mine
  attr_accessible :title, :fields_attributes
  has_many :fields
  accepts_nested_attributes_for :fields
end
