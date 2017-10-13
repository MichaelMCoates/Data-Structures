class Heap
  def initialize(&prc)
    self.store = []
    self.prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    first_child_index = 2 * parent_index + 1
    second_child_idx = 2 * parent_index + 2

    if len > second_child_idx
      return [first_child_index, second_child_idx]
    elsif len > first_child_index
      return [first_child_index]
    else
      return nil
    end
  end

  def self.parent_index(child_index)
    return nil if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    child_indices = self.child_indices(len, parent_idx)
    return if child_indices == nil

    children = child_indices.map { |child_idx| array[child_idx] }
    smallest_child = nil
    smallest_child_idx = nil

    if children.length == 1
      smallest_child = children[0]
      smallest_child_idx = child_indices[0]
    else
      smallest_child = prc.call(children[0], children[1]) ? children[1] : children[0]
      smallest_child_idx = prc.call(children[0], children[1]) ? child_indices[1] : child_indices[0]
    end

    parent = array[parent_idx]

    if parent > smallest_child
      array[parent_idx], array[smallest_child_idx] = array[smallest_child_idx], array[parent_idx]
      heapify_down(array, smallest_child_idx, len, &prc)
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
