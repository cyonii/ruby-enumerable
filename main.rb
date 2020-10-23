module Enumerable
  def my_each
    yield self
  end
end

['John', 23, 90, 77, 'Foo'].my_each { |item| puts item }
