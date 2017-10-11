require_relative 'hashing_functions'

class HashSet
  attr_reader :count

  def initialize(num_of_buckets = 8)
    @store = Array.new(num_of_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)

    @count += 1
    self.resize! if @count < num_of_buckets

    self[num] << num
    num
  end

  def remove(num)
    if self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num.hash % num_of_buckets]
  end

  def num_of_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_of_buckets * 2) { Array.new }

    old_store.each do |bucket|
      bucket.each do |el|
        self.insert(el)
    end
  end
end
