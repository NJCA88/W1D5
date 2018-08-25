require_relative "00_tree_node"

class KnightPathFinder
  attr_accessor :added_moves, :move_tree

  def initialize(pos)
    @added_moves = [pos]
    @move_tree = PolyTreeNode.new(pos)
    build_move_tree(@move_tree)
  end

  def build_move_tree(node)
    return nil if node.nil?
    self.find_moves(node.value).each do |move|
      child = PolyTreeNode.new(move)
      node.add_child(child)
      @added_moves << move
      self.build_move_tree(child)
    end
  end

  def find_moves(pos)
    x,y = pos
    moves = [[x+2, y+1], [x+2, y-1], [x+1, y+2], [x+1, y-2],
              [x-2, y-1], [x-2, y+1], [x-1, y-2], [x-1, y+2]]
    moves.select{|move| is_valid?(move)}
  end

  def is_valid?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7) && !@added_moves.include?(pos)
  end

  def find_path(end_pos)
      node = @move_tree.bfs(end_pos)
      trace_path_back(node)
  end

  def trace_path_back(node)
    return [node.value] if node.parent.nil?
    trace_path_back(node.parent) + [node.value]
  end

end
