class StaticArray
  def initialize(length)
    self.store = Array.new(length)
  end

  def [](index)
    @store[index]
  end

  def []=(index, value)
    @store[index] = value
  end

  protected
  attr_accessor :store

end
