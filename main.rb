module Enumerable
  def my_each
    yield self
  end

  def my_each_with_index
    counter = 0
      # puts "#{value}: #{index}"
    for item in self
      yield item, counter
      counter += 1
    end
  end
end

['John', 23, 90, 77, 'Foo'].my_each { |item| puts "#{item}" }


['John', 23, 90, 77, 'Foo'].each_with_index { |item, index| puts "#{item}, #{index}" }
