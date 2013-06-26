class Field < ActiveRecord::Base
  extend Enumerize

  attr_accessible :kind, :title, :weight

  belongs_to :configuration

  enumerize :kind, :in => [:quality, :quantity], :predicates => true
end
