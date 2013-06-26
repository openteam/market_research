class Field < ActiveRecord::Base
  extend Enumerize

  belongs_to :configuration
  attr_accessible :kind, :title, :weight

  enumerize :kind, :in => [:quality, :quantity]
end
