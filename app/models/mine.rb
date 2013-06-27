# encoding: utf-8

class Mine < ActiveRecord::Base
  has_many :configurations, :dependent => :destroy
  has_many :groupings,      :dependent => :destroy
  has_many :items,          :dependent => :destroy

  def items_options
    result = {}
    items.each do |item|
      item.data.to_h.keys.map(&:to_s).each do |key|
        result[key] ||= []
        result[key] << item.data.send(key) unless result[key].include?(item.data.send(key))
      end
    end

    result
  end
end
