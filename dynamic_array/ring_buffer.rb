require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.length = 0
    self.capacity = 8
    self.start_idx = 0
  end

  def [](index)
    check_index(index)
    self.store[(start_idx + index) % capacity]
  end

  def []=(index, value)
    check_index(index)
    self.store[(start_idx + index) % capacity] = value
  end

  def push(value)
    self.resize if length == capacity

    self.length += 1
    self[length - 1] = value

    nil
  end

  def pop
    popped_el = self[length - 1]

    self[length - 1] = nil
    self.length -= 1

    popped_el
  end

  def unshift(value)
    self.resize if length == capacity

    self.length += 1
    self.start_idx = (start_idx - 1) % capacity

    self[0] = value
  end

  def shift
    shifted_el = self[0]
    self[0] = nil

    self.length -= 1
    self.start_idx = (start_idx + 1) % capacity

    shifted_el
  end

  protected
  attr_accessor :store, :capacity, :start_idx
  attr_writer :length

  def check_index(index)
    unless index >= 0 && index < length
      raise "index out of bounds"
    end
  end

  def resize
    new_capacity = self.capacity * 2
    new_store = StaticArray.new(new_capacity)

    self.length.times do |idx|
      # New_store's index at 0 is different from self's index at 0, because new_store is just a StaticArray, and
      # self in this case is the RingBuffer.
      # New_store will have the numbers at index of 0, while self will use the RingBuffer bracket methods.
      # Thus, we are allowed to reset our start_idx to 0 later.
      new_store[idx] = self[idx]
    end

    self.capacity = new_capacity
    self.store = new_store
    self.start_idx = 0
  end
end
