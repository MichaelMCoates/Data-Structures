class IntSet
  def initialize(num_of_buckets = 20)
    @store = Array.new(num_of_buckets) { Array.new }
  end

  def insert(num)
    return false if self.include?(num)

    self[num] << num
    num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_of_buckets]
  end

  def num_of_buckets
    @store.length
  end
end
