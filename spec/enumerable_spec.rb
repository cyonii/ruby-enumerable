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
end
