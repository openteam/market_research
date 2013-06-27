class GroupingParameter < ActiveRecord::Base
  attr_accessible :title

  belongs_to :grouping
end
