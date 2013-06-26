class Parameter < ActiveRecord::Base
  attr_accessible :value, :field_id

  belongs_to :segment
  belongs_to :field

  delegate :quality?, :quantity?, :min_value, :max_value, :weight, :set_min_and_max_value,
    :to => :field
  delegate :title, :to => :field, :prefix => true
end
