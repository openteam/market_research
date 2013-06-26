# encoding: utf-8

class Item < ActiveRecord::Base
  attr_accessible :data
  belongs_to :mine
  serialize :data, OpenStruct
end
