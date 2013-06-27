class Grouping < ActiveRecord::Base
  attr_accessible :title, :grouping_parameters_attributes

  belongs_to :mine

  has_many :grouping_parameters, :dependent => :destroy

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true

  def foo(grouping_parameter, conditions = {})
    if grouping_parameter.nil?
      return Item.with(conditions).map(&:id)
    end

    hash ||= {}
    mine.items_options[grouping_parameter.title].each { |title| hash[title] = nil }

    hash.each do |title, _|
      hash[title] = foo(grouping_parameters[grouping_parameters.index(grouping_parameter) + 1], conditions.merge(grouping_parameter.title => title))
    end

    hash
  end

  def bar
    foo(grouping_parameters.first)
  end
end
