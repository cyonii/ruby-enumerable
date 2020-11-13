require_relative '../enumerable.rb'

describe Enumerable do
  let(:num_array) { [1, 2, 3, 4, 5] }
  let(:uniform_arr) { [10, 10, 10, 10, 10] }
  let(:random_arr) { [2, true, 'ruby', nil, 0, false] }

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

    it 'yield all elements with their respective indexes' do
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
      selected_arr = num_array.my_select { |item| (item + 1).even? }
      expect(selected_arr).to eql([1, 3, 5])
    end
  end

  describe '#my_all?' do
    context 'when neither argument NOR block is given' do
      it 'returns false if any element in the enumerable is falsy' do
        expect(random_arr.my_all?).to be(false)
      end

      it 'returns true if all elements in the enumerable are truthy' do
        expect(num_array.my_all?).to be(true)
      end
    end

    context 'when block is given' do
      it 'returns false if any block expression returns false' do
        expect(random_arr.my_all? { |item| item.is_a(String) })
      end

      it 'returns true if all block expression returns true' do
        expect(num_array.my_all? { |item| item.is_a?(Numeric) })
      end
    end

    context 'when arguments is passed' do
      context 'when arguments is a Class' do
        it 'returns false if all element are not instance of given Class' do
          expect(random_arr.my_all?(String)).to be(false)
        end

        it 'returns true if all elements are instance of given Class' do
          expect(num_array.my_all?(Integer)).to be(true)
        end
      end

      context 'when arguments is Regexp' do
        it 'returns false if all elements does not match pattern' do
          expect(random_arr.my_all?(/\d+/)).to be(false)
        end

        it 'returns true if all elements match given pattern' do
          expect(num_array.my_all?(/\d{1}/)).to be(true)
        end
      end

      context 'when arguments is an expression' do
        it 'returns false if all elements are not equal to expression' do
          expect(num_array.my_all?(2 * 2)).to be(false)
        end

        it 'returns true if all elements are equal to expression' do
          expect(uniform_arr.my_all?(5 * 2)).to be(true)
        end
      end
    end
  end
end
