class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove!
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }

    nil
  end

  def first
    return nil if self.empty?

    @head.next
  end

  def last
    return nil if self.empty?

    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end

    nil
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def append(key, val)
    new_link = Link.new(key, val)
    @tail.prev.next = new_link
    new_link.prev = @tail.prev

    @tail.prev = new_link
    new_link.next = @tail

    new_link
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val

        return link
      end
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.remove!

        return link
      end
    end
  end

  def each
    current_link = @head.next

    until current_link == @tail
      yield current_link

      current_link = current_link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

a = LinkedList.new
a.append(1, 2)
a.append(2, 3)
a.remove(1)
