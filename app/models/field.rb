class Field < ActiveRecord::Base
  extend Enumerize

  attr_accessible :kind, :title, :weight

  belongs_to :configuration

  enumerize :kind, :in => [:quality, :quantity], :predicates => true

  def set_min_and_max_value
    if quantity?
      self.min_value = configuration.mine.items_options[title].map(&:to_i).sort.first
      self.max_value = configuration.mine.items_options[title].map(&:to_i).sort.last if quantity?
      self.save!
    end
  end
end
