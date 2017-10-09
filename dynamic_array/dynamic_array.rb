require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.static_array = StaticArray.new(4)
    self.length = 0
    self.capacity = 4
  end


  protected
  attr_writer :static_array, :length, :capacity



end
