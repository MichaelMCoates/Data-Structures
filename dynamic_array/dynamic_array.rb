require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.length = 0
    self.capacity = 8
  end

  def [](index)
    check_index(index)
    self.store[index]
  end

  def []=(index, value)
    check_index(index)
    self.store[index] = value
  end

  def push(value)
    self.length += 1
    self[length - 1] = value
  end

  def pop
    self[length - 1] = nil
    self.length -= 1
  end

  def unshift(value)
    self.length += 1

    (self.length - 1).downto(1).each { |idx| self[idx] = self[idx - 1] }
    self[0] = value
  end

  def shift
    shifted_el = self[0]
    (1..self.length - 1).each { |idx| self[idx - 1] = self[idx] }
    self.length -= 1

    shifted_el
  end



  protected
  attr_accessor :store, :capacity
  attr_writer :length

  def check_index(index)
    unless index >= 0 && index < length
      raise "index out of bounds"
    end
  end


end
