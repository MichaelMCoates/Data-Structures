require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.static_array = StaticArray.new(8)
    self.length = 0
    self.capacity = 8
  end

  def [](index)
    self.static_array[index]
  end

  def []=(index, value)
    self.static_array[index] = value
  end



  protected
  attr_accessor :static_array, :capacity
  attr_writer :length



end
