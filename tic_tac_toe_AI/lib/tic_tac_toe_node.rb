require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    childs = []
    (0...board.rows.length).each do |row|
      (0...board.rows.length).each do |col|
        pos = [row, col]
        if board.empty?(pos)
          temp = board.dup
          temp[pos] = next_mover_mark
          childs << TicTacToeNode.new(temp, switch_mark, pos)
        end
      end
    end
    childs
  end

  def switch_mark
    if next_mover_mark == :x
      return :o
    else
      return :x
    end
  end

  def losing_node?
    if board.over? and board.winner? == next_mover_mark
      return true 
    elsif board.over?
      return false
    end

    children.each do |child|

    end
    
  end

  attr_reader :board, :next_mover_mark, :prev_move_pos
end
