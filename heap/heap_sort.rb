require_relative "heap"

class Array
  def heap_sort_out_of_place!
    new_heap = Heap.new
    self.each do |el|
      new_heap.push(el)
    end

    sorted = []

    self.length.times do |x|
      sorted.push(new_heap.extract)
    end

    sorted
  end

  def heap_sort!
    2.upto(self.length).each do |heap_bound|
      Heap.heapify_up(self, heap_bound - 1, heap_bound)
    end

    (self.length).downto(2).each do |heap_bound|
      self[heap_bound - 1], self[0] = self[0], self[heap_bound - 1]
      Heap.heapify_down(self, 0, heap_bound - 1)
    end

    self.reverse!
  end
end
