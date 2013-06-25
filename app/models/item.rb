# encoding: utf-8

class Item < ActiveRecord::Base
  attr_accessible :data
  serialize :data, OpenStruct
end
