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




end
