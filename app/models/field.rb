class Field < ActiveRecord::Base
  extend Enumerize

  attr_accessible :kind, :title, :weight

  belongs_to :configuration

  enumerize :kind, :in => [:quality, :quantity], :predicates => true

  def min_value
    configuration.mine.items_options[title].map(&:to_i).sort.first if quantity?
  end

  def max_value
    configuration.mine.items_options[title].map(&:to_i).sort.last if quantity?
  end
end
