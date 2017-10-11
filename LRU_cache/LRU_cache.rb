require_relative '../hash_map/hash_map'
require_relative '../linked_list/linked_list'

class LRUCache
  attr_reader :count
  def initialize(max_items, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max_items = max_items
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map[key]
      update_link!(link)
      link.val
    else
      add_link!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def add_link!(key)
    value = @prc.call(key)

    new_link = @store.append(key, value)
    @map[key] = new_link

    self.eject! if self.count > @max_items
    value
  end

  def update_link!(link)
    link.remove
    @map[link.key] = @store.append(link.key, link.val)
  end

  def eject!
    ejected_link = store.first
    ejected_link.remove
    @map.delete(ejected_link.key)
    nil
  end
end
