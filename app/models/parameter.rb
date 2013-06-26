class Parameter < ActiveRecord::Base
  attr_accessible :value, :field_id

  belongs_to :segment
  belongs_to :field
end
