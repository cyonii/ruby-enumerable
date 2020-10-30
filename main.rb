# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
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
    my_each { |value| return false unless value }

    if block_given?
      my_each { |value| return false unless yield(value) }
    end

    if to_check.is_a?(Class)
      my_each { |value| return false unless value.is_a?(to_check) }

    elsif to_check.is_a?(Regexp)
      my_each { |value| return false unless value.to_s.match(to_check) }

    elsif !to_check.nil?
      my_each { |value| return false unless value == to_check }
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
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

my_array = ['John', 2, 16, 222, 23, 90, 77, 'Foo', 90, 12]

p(my_array.my_all? { |i| i.is_a?(Numeric) })

# my_array.my_each { |item| puts item }

# my_array.my_each_with_index { |item, index| puts "#{item}, #{index}" }

# var = (0..10).my_select(&:odd?)
# puts var

# p %w[this this this].my_all?

# puts my_array.my_any?('John')

# p(my_array.my_none? { |item| item == 9 })

# puts my_array.my_count

# new_proc = proc { |item| item.to_s + 2.to_s }
# p my_array.my_map(&new_proc)

# p [2, 4, 5].my_inject(nil) { |sum, n| sum * n }

# p multiply_els([2, 4, 5])
