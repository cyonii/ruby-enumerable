require_relative '../enumerable.rb'

describe Enumerable do
  let(:num_array) { [1, 2, 3, 4, 5] }
  let(:uniform_arr) { [10, 10, 10, 10, 10] }
  let(:random_arr) { [2, true, 'ruby', nil, 0, false] }
  let(:falsy_arr) { [nil, false] }

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

  describe '#my_any?' do
    context 'when no block or expressions are given' do
      it 'returns false if no elements is truthy' do
        expect(falsy_arr.my_any?).to be(false)
      end

      it 'returns true if any elements is truthy' do
        expect(random_arr.my_any?).to be(true)
      end
    end

    context 'when block is given' do
      it 'returns true if any elements in the block expression return true' do
        expect(num_array.my_any? { |item| item - 1 == 0 }).to be(true)
      end

      it 'returns false if no elements in the block expression is true' do
        expect(num_array.my_any? { |item| item + 1 == 10 }).to be(false)
      end
    end

    context 'when arguments is passed' do
      context 'when a class is passed as an argument' do
        it 'return true if any element is an instance of a given class' do
          expect(random_arr.my_any?(String)).to be(true)
        end

        it 'return false is no element is an instance of a given class' do
          expect(num_array.my_any?(String)).to be(false)
        end
      end

      context 'when argument given is a regexp' do
        it 'return true if any element match the given pattern' do
          expect(random_arr.my_any?(/\wy$/)).to be(true)
        end

        it 'return false if no element match the given pattern' do
          expect(random_arr.my_any?(/\d{2}/)).to be(false)
        end
      end

      context 'when given argument is an expression' do
        it 'return true if any element is equal to expression' do
          expect(num_array.my_any?(2 * 2)).to be(true)
        end

        it 'return false if no element is equal to the expression' do
          expect(uniform_arr.my_any?(2 * 2)).to be(false)
        end
      end
    end
  end

  describe '#my_none?' do
    context 'when neither argument nor block is given' do
      it 'returns false if an element is truthy' do
        expect([*falsy_arr, 1].my_none?).to be(false)
      end

      it 'returns true if no element is truthy' do
        expect(falsy_arr.my_none?).to be(true)
      end
    end

    context 'when block is given' do
      it 'returns false if block ever returns true' do
        expect(num_array.my_none? { |item| item + 2 == 3 }).to be(false)
      end

      it 'returns true if all block returns are false' do
        expect(num_array.my_none? { |item| item / 2 == 10 }).to be(true)
      end
    end

    context 'when argument is passed' do
      context 'when passed argument is a Class' do
        it 'returns false if any element is an instance of given Class' do
          expect(random_arr.my_none?(Integer)).to be(false)
        end

        it 'returns true if no element is instance of given Class' do
          expect(num_array.my_none?(Float)).to be(true)
        end
      end

      context 'when passed argument is a Regexp' do
        it 'returns false if any element matches given pattern' do
          expect(random_arr.my_none?(/\wy$/)).to be(false)
        end

        it 'returns true if no element matches given pattern' do
          expect(random_arr.my_none?(/\wing$/)).to be(true)
        end
      end

      context 'when argument is an expression' do
        it 'returns false if any element is equal to expression' do
          expect(num_array.my_none?(2 + 2)).to be(false)
        end

        it 'returns true if no element is equal to expression' do
          expect(num_array.my_none?(4.5)).to be(true)
        end
      end
    end
  end

  describe '#my_count?' do
    context 'when block or argument is not given' do
      it 'return a number of elements ' do
        expect(num_array.my_count).to eql(5)
      end
    end

    context 'when a block is given' do
      it 'return the number of elements that yielding a true value' do
        expect(num_array.my_count { |item| (item + 1).odd? }).to eql(2)
      end
    end

    context 'when an argument is given' do
      it 'return the number of element that are equal to argument given' do
        expect(num_array.my_count(2)).to eql(1)
      end
    end
  end

  describe '#my_map' do
    context 'when no argument or block is given' do
      it 'returns an Enumerator object' do
        expect(random_arr.my_map).to be_a(Enumerator)
      end
    end

    context 'when block is given' do
      it 'returns a new array with the results of running block' do
        selected = num_array.my_map { |item| item + 1 }
        expect(selected).to eql([2, 3, 4, 5, 6])
      end
    end

    context 'when argument is given' do
      context 'when argument is a Proc' do
        it 'returns a new array with the value of running proc' do
          my_proc = proc { |item| item * 2 }
          expect(num_array.my_map(my_proc)).to eql([2, 4, 6, 8, 10])
        end
      end
    end
  end

  describe '#my_inject' do
    context 'when more than 2 arguments are given' do
      it 'raises ArgumentError' do
        expect { num_array.my_inject(1, 2, 3) }.to raise_error(ArgumentError)
      end
    end

    context 'when argument is given and block is not given' do
      context 'when only 1 argument is given' do
        it 'uses symbol as mathematical symbol effectively' do
          expect(num_array.my_inject(:+)).to eql(15)
        end

        it 'uses character as mathematical operator effectively' do
          expect(num_array.my_inject('*')).to eql(120)
        end
      end

      context 'when 2 arguments are given' do
        it 'uses first arg as base and second arg as mathematical operator' do
          expect(num_array.my_inject(10, :+)).to eql(25)
          expect(num_array.my_inject(1, '*')).to eql(120)
        end
      end
    end

    context 'when both argument and block is passed' do
      it 'returns the result of running block using argument as base' do
        expect(num_array.my_inject(10) { |sum, item| sum + item }).to eql(25)
      end
    end

    context 'when only block is given' do
      it 'returns the result of running block' do
        expect(num_array.my_inject { |sum, item| sum + item }).to eql(15)
      end
    end
  end
end
