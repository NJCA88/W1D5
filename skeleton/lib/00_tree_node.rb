class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    @parent.children.delete(self) if !@parent.nil?
    @parent = parent_node
    parent_node.children << self if !@parent.nil? &&
      !parent_node.children.include?(self)
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      @children.delete(child_node)
    else
      raise "#{child_node} is not a child of #{self}"
    end
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    @children.each do |child|
      found_node = child.dfs(target_value)
      return found_node unless found_node.nil?
    end
    return nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each {|child| queue << child}
    end
    return nil
  end




















  # def bfs(target_value)
  #   queue = [self]
  #   until queue.empty?
  #     current = queue.shift
  #     return current if current.value == target_value
  #     @children.each{ |child| queue.push(child) }
  #   end
  #   return nil
  # end

end
