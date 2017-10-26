require 'test_helper'
require 'misty/http/client'

describe Misty::HTTP::Header do
  describe 'create' do
    it 'successful with Hash parameter' do
      header = Misty::HTTP::Header.new('key 1' => 'value 1', 'key 2' => 'value 2')

      header.get.must_equal ({'key 1' => 'value 1', 'key 2' => 'value 2'})
    end

    it 'fails when parameter is not a Hash' do
      proc do
        header = Misty::HTTP::Header.new('A string')
      end.must_raise Misty::HTTP::Header::TypeError
    end

    it 'fails when a key is not a String' do
      proc do
        header = Misty::HTTP::Header.new('key 1' => 'value 1', 2 => 'value 2')
      end.must_raise Misty::HTTP::Header::ArgumentError
    end

    it 'fails when a value is not a String' do
      proc do
        header = Misty::HTTP::Header.new('key 1' => 'value 1', 'key 2' => 2)
      end.must_raise Misty::HTTP::Header::ArgumentError
    end
  end

  describe 'add' do
    it 'merge headers' do
      header = Misty::HTTP::Header.new('key 1' => 'value 1', 'key 2' => 'value 2')
      header.add('key 3' => 'value 3', 'key 4' => 'value 4')

      header.get.must_equal ({'key 1' => 'value 1', 'key 2' => 'value 2', 'key 3' => 'value 3', 'key 4' => 'value 4'})
    end
  end
end
