require 'pry'

module Enumerable
  def my_each
    for item in self
      yield item
    end
  end

  def my_each_with_index
    counter = 0
    my_each do |item|
      yield item, counter
      counter += 1
    end

  end

  def my_select
    selected = []
    my_each {|item| selected.push(item) if yield(item)}
    selected
  end

  def my_all?
    my_each_with_index do |item, index|
      next unless self[index + 1]

      return false unless item == self[index + 1]
    end
    return true
  end
end

['John', 23, 90, 77, 'Foo'].my_each { |item| puts item }

['John', 23, 90, 77, 'Foo'].my_each_with_index { |item, index| puts "#{item}, #{index}" }

var = (0..10).my_select { |item| item.odd? }
puts var


p %w[this this this].my_all?
