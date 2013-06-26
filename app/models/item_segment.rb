class ItemSegment < ActiveRecord::Base
  attr_accessible :distance, :item_id

  belongs_to :item
  belongs_to :segment

  validates_uniqueness_of :item_id, :scope => :segment_id

  def as_json
    super(:only => [:distance, :segment_id])
  end
end
