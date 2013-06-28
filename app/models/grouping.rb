class Grouping < ActiveRecord::Base
  attr_accessible :title, :grouping_parameters_attributes

  belongs_to :mine

  has_many :grouping_parameters, :dependent => :destroy

  accepts_nested_attributes_for :grouping_parameters, :allow_destroy => true

  def baz(hash = { 'name' => 'root'}, enumerator = grouping_parameters.each, conditions = {})
    begin
      grouping_parameter = enumerator.next
    rescue
      items = Item.with(conditions)

      if items.any?
        return hash.merge('children' => items.map { |item| { 'name' => item.data['Наименование'], 'size' => 1 } })
      else
        return nil
      end

    end

    hash['children'] = []
    (mine.items_options[grouping_parameter.title]).each do |title|
      children = baz({'name' => title}, enumerator, conditions.merge(grouping_parameter.title => title))
      hash['children'] << children if children
    end

    hash
  end

  def foo(grouping_parameter, conditions = {}, hash = nil)
    if grouping_parameter.nil?
      return Item.with(conditions).map(&:id)
      #return []
    end

    hash ||= { 'name' => 'root' }
    #mine.items_options[grouping_parameter.title].each { |title| hash[title] = nil }
    mine.items_options[grouping_parameter.title].each { |title| hash['children'] = nil }

    #hash.each do |title, _|
      #hash['children'] = foo(grouping_parameters[grouping_parameters.index(grouping_parameter) + 1], conditions.merge(grouping_parameter.title => title))
    #end

    grouping_parameters.each do |grouping_parameter|
      p mine.items_options[grouping_parameter.title]
      hash['children'] = foo(grouping_parameters[grouping_parameters.index(grouping_parameter) + 1], conditions.merge(grouping_parameter.title => '11'))
    end

    hash
  end

  def bar
    #foo(grouping_parameters.first)
    baz
  end
end
