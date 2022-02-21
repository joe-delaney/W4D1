require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    #Array to store all possible moves
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

  #This will return mark of current mover to be used when creating new nodes
  def switch_mark
    if next_mover_mark == :x
      return :o
    else
      return :x
    end
  end

  require "byebug"
  def losing_node?(evaluator)
    #If game is complete and the opponent has won and it is not a tie,
    #return true because this is a losing node, otherwise return false
    debugger
    if board.over? && board.winner != evaluator && !board.tied?
      return true 
    elsif board.over?
      return false
    end
    debugger
    #Recursively check to see if all children from the current node result in
    #a loss or if only one results in a loss (computer will target this one)
    children.one? {|child| child.losing_node?(evaluator)} ||
      children.all? {|child| child.losing_node?(evaluator)}
      
  end

  def winning_node?(evaluator)
    #If game is complete and winner is us, return true
    if board.over? && board.winner == evaluator
      return true 
    elsif board.over?
      return false 
    end

    #Recursively check to see if all children of the current node are winners for
    #us or we only have one possible winner from the current node
    children.all? {|child| child.winning_node?(evaluator)} ||
      children.one? {|child| child.winning_node?(evaluator)}
  end

  attr_reader :board, :next_mover_mark, :prev_move_pos
end
