require_relative '../enumerable.rb'

describe Enumerable do
  let(:num_array) { [1, 2, 3, 4, 5] }

  describe '#my_each' do
    it 'returns an Enumerator when block is NOT given' do
      expect(num_array.my_each).to be_an(Enumerator)
    end

    it 'yields all elements of the enumerable' do
      total = 0
      temp_arr = []
      num_array.my_each do |item|
        total += item
        temp_arr << item * item
      end
      expect(total).to eql(15)
      expect(temp_arr).to eql([1, 4, 9, 16, 25])
    end

    it 'returns the caller' do
      expect(num_array.my_each {}).to eq(num_array)
    end
  end

  describe '#my_each_with_index' do
  it 'return an enumerator if block is not given' do
    expect(num_array.my_each_with_index).to be_an(Enumerator)
  end

  it 'yield all elements with they are respective indexes' do
    new_array = []
    counter = 0
    num_array.my_each_with_index do |item, index|
      counter += item
      new_array << index + 10
    end
   expect(new_array).to eql([10, 11, 12, 13, 14])
   expect(counter).to eql(15)
  end
 end

 describe '#my_select' do
   it 'return an enumerator if block is not given' do
   expect(num_array.my_select).to be_an(Enumerator)
  end

  it 'returns a new array that met the condition given' do
   selected_arr = num_array.my_select {|item| item.even? }
   expect(selected_arr).to eql([2, 4])
  end 
 end
end
