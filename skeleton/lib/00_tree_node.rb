require "byebug"

class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node) #accepts node_object
    self.parent.children.delete(self) unless @parent.nil?
    @parent = node
    return if node.nil?
    node.children << self unless node.children.include?(self) 
  end

  def add_child(child_node)
    self.children << child_node
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise unless @children.include?(child_node)
    self.children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    # debugger
    self.children.each do |child|
      node = child.dfs(target_value)
      return node unless node.nil?
    end
    nil
  end

  def bfs(target_value)
    # return self if self.value == target_value
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end

  
end

# n1 = PolyTreeNode.new(4)
# n2 = PolyTreeNode.new(3)
# n1.parent = (n2)

# p n1
# p n2