require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    #Arrayy to store all possible moves
    childs = []
    #Go through each position on board
    (0...board.rows.length).each do |row|
      (0...board.rows.length).each do |col|
        pos = [row, col]
        #If board position is emtpy, it represents a possible move
        if board.empty?(pos)
          #create a duplicate of the board, set it equal to next mover mark, and
          #add it to the array of possible moves for this node
          temp = board.dup
          temp[pos] = next_mover_mark
          childs << TicTacToeNode.new(temp, switch_mark, pos)
        end
      end
    end
    #return possible moves
    childs
  end

  def switch_mark
    if next_mover_mark == :x
      return :o
    else
      return :x
    end
  end

  def losing_node?(evaluator)
    if board.over? and board.winner != evaluator && !board.tied?
      return true 
    elsif board.over?
      return false
    end

    children.all? {|child| child.losing_node?(evaluator)} ||
      children.one? {|child| child.losing_node?(evaluator)}
    
  end

  attr_reader :board, :next_mover_mark, :prev_move_pos
end
