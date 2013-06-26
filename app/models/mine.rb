# encoding: utf-8

class Mine < ActiveRecord::Base
  has_many :items
  has_many :configurations

  def items_options
    result = {}
    items.each do |item|
      item.data.to_h.keys.each do |key|
        result[key] ||= []
        result[key] << item.data.send(key) unless result[key].include?(item.data.send(key))
      end
    end
    result
  end
end
