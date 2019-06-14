require_relative "/Users/aa/Desktop/W1D5/skeleton/lib/00_tree_node.rb"

class KnightPathFinder 
  
  def initialize(position)
    @root_node = position
    @considered = [position]
  end

  def self.valid_moves(pos)
    movements = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [-1,2], [1,-2], [-1,-2]]
    movements.map! do |moves| 
      [moves[0] + pos[0], moves[1]+pos[1]]
    end
    movements.reject {|positions| positions[0] < 0 || positions[0] > 7 || positions[1] < 0 || positions[1] >7}
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    valid_moves = []
    possible_moves.each do |move|
      if !@considered.include?(move)
        @considered << move
        valid_moves << move
      end 
    end
    valid_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@root_node)
    queue = [root]
    until queue.empty?
      parent_node = queue.shift
      moves = new_move_positions(parent_node.value)
      moves.each do |move|
        move = PolyTreeNode.new(move)
        move.parent = parent_node
        queue << move
      end
    end
    @considered = [@root_node]
    root
  end

  def find_path(end_pos)
    trace_path_back(self.build_move_tree.bfs(end_pos))

  end

  def trace_path_back(end_node)
    path = []
    node = end_node
    until node.parent == nil
      path << node.value
      node = node.parent
    end
    path << @root_node
    path.reverse
  end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
