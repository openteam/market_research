class GroupingParameter < ActiveRecord::Base
  extend Enumerize
  attr_accessible :title, :kind

  belongs_to :grouping

  enumerize :kind, :in => [:quality, :quantity], :predicates => true
end
