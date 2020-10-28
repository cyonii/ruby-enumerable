module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for item in self
      yield item
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    counter = 0
    my_each do |item|
      yield item, counter
      counter += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    my_each { |item| selected.push(item) if yield(item) }
    selected
  end

  def my_all?(to_check = nil)
    return true if !to_check and length

    my_each_with_index do |item, index|
      next unless self[index + 1]

      return false unless item == self[index + 1]
    end
    true
  end

  def my_any?(to_check = nil)
    return true if !to_check and length

    my_each do |item|
      return true if item == to_check
    end
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_each do |item|
      return false if yield(item)
    end
    true
  end

  def my_count
    counter = 0

    my_each do
      counter += 1
    end

    counter
  end

  def my_map(&my_proc)
    return to_enum(:my_map) unless block_given?

    map_list = []

    my_each { |item| map_list.push(my_proc.call(item)) }
    map_list
  end

  def my_inject(initial = nil)
    total = initial || self[0]
    counter = initial ? 0 : 1

    my_each do
      total = yield(total, self[counter]) if self[counter]
      counter += 1
    end
    total
  end
end

def multiply_els(array)
  product = 1
  for i in array
    product *= i
  end
  product
end

my_array = ['John', 2, 16, 222, 23, 90, 77, 'Foo', 90, 12]

puts 'original list on which we worked:'
puts my_array.to_s

puts "\n---------------------------------\n"
puts 'Running my_each method:'
my_array.my_each { |item| puts item }

puts "\n---------------------------------\n"
puts "\nRunning my_each_with_index method:"
my_array.my_each_with_index { |item, index| puts "#{item}, #{index}" }

puts "\n---------------------------------\n"
puts "\nRunning my_select method:"
var = (0..10).my_select { |item| item.odd? }
puts var

puts "\n---------------------------------\n"
puts "\nRunning my_all? method:"
p %w[this this this].my_all?

puts "\n---------------------------------\n"
puts "\nRunning my_any? method:"
puts my_array.my_any?('John')

puts "\n---------------------------------\n"
puts "\nRunning my_none?_index method:"
p my_array.my_none? {|item| item == 9}

puts "\n---------------------------------\n"
puts "\nRunning my_count method:"
puts my_array.my_count

puts "\n---------------------------------\n"
puts "\nRunning my_map method:"
new_proc = Proc.new { |item| item.to_s + 2.to_s }
p my_array.my_map(&new_proc)

puts "\n---------------------------------\n"
puts "\nRunning my_inject method:"
p [2, 4, 5].my_inject { |sum, n| sum * n }

puts "\n---------------------------------\n"
puts "\nRunning multiply_els method to test the output from my_inject method:"
p multiply_els([2, 4, 5])
