class Segment < ActiveRecord::Base
  has_many :item_segments,      :dependent => :destroy
  has_many :items,              :through => :item_segments
end
