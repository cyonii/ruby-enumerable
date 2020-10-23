module Enumerable
  def my_each
    for item in self
      yield item
    end
  end

  def my_each_with_index
    counter = 0
    for item in self
      yield item, counter
      counter += 1
    end
  end

  def my_select
    selected = []
    my_each {|item| selected.push(item) if yield(item)}
    selected
  end
end

['John', 23, 90, 77, 'Foo'].my_each { |item| puts item }

['John', 23, 90, 77, 'Foo'].my_each_with_index { |item, index| puts "#{item}, #{index}" }

var = (0..10).my_select { |item| item.odd? }
puts var
