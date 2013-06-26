class Configuration < ActiveRecord::Base
  attr_accessible :title, :fields_attributes

  belongs_to :mine

  has_many :fields, :dependent => :destroy
  has_many :segments, :dependent => :destroy

  accepts_nested_attributes_for :fields
end
