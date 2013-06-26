class ItemSegment < ActiveRecord::Base
  attr_accessible :distance, :item_id

  belongs_to :item
  belongs_to :segment

  validates_uniqueness_of :item_id, :scope => :segment_id
end
