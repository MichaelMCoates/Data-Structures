class StaticArray
  def initialize(length)
    self.store = Array.new(length)
  end

  def [](index)
    self.store[index]
  end

  def []=(index, value)
    self.store[index] = value
  end

  protected
  attr_accessor :store

end
