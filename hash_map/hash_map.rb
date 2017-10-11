require_relative '../hash_set/hashing_functions'
require_relative '../linked_list/linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_of_buckets = 8)
    @store = Array.new(num_of_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if self.include?(key)
      bucket(key).update(key, val)
    else
      @count += 1
      resize! if @count < num_of_buckets

      bucket(key).append(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        yield [link.key, link.val]
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_of_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_of_buckets * 2) { LinkedList.new }

    old_store.each do |bucket|
      bucket.each do |link|
        self.set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_of_buckets]
  end
end
