class TreeNode
  attr_accessor :left, :right, :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if !@root
      @root = TreeNode.new(value)
      return
    end

    BinarySearchTree.insert!(@root, value)
  end

  def self.insert!(node, value)
    return TreeNode.new(value) unless node

    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end

    node
  end

  def min
    BinarySearchTree.min(@root)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left

    BinarySearchTree.min(node.left)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def self.max(node)
    return nil unless node
    return node unless node.right

    BinarySearchTree.max(node.right)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value

    if value < node.value
      return BinarySearchTree.find!(node.left, value)
    end

    BinarySearchTree.find!(node.right, value)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def self.height!(node)
    return -1 unless node

    1 + [BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      t = node
      node = t.right.min
      node.right = BinarySearchTree.delete_min!(t.right)
      node.left = t.left
    end

    node
  end

end
