require_relative "/Users/aa/Desktop/W1D5/skeleton/lib/00_tree_node.rb"

class KnightPathFinder 
  
  def initialize(position)
    @root_node = position
    @considered = [position]
  end

  def self.valid_moves(pos)
    movements = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [-1,2], [1,-2], [-1,-2]]
    possible_moves = movements.map do |moves| 
      [moves[0] + pos[0], moves[1]+pos[1]]
    end
    possible_moves.reject {|positions| positions[0] < 0 || positions[0] > 7 || positions[1] < 0 || positions[1] >7}
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

  def build_move_tree(pos=@root_node)
    parent_node = PolyTreeNode.new(pos)

    moves = new_move_positions(pos)
    moves.each do |move|
      move = PolyTreeNode.new(move)
      move.parent = parent_node
    end
    parent_node
  end

  def find_path(end_pos)
    
  end

end