require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.static_array = StaticArray.new(8)
    self.length = 0
    self.capacity = 8
  end

  def [](index)
    check_index(index)
    self.static_array[index]
  end

  def []=(index, value)
    check_index(index)
    self.static_array[index] = value
  end

  def push(value)
    self.length += 1
    self[length - 1] = value
  end

  def pop
    self[length - 1] = nil
    self.length -= 1
  end



  protected
  attr_accessor :static_array, :capacity
  attr_writer :length

  def check_index(index)
    unless index >= 0 && index < length
      raise "index out of bounds"
    end
  end


end
