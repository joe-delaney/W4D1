require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  require "byebug"
  def move(game, mark)
    debugger
    #next_mark = mark == :x ? :o : :x
    current_node = TicTacToeNode.new(game.board, mark)
    moves = current_node.children
    moves.each do |move|
      return move.prev_move_pos if move.winning_node?(mark)
    end
    
    moves.each do |move|
      return move.prev_move_pos if !move.losing_node?(mark)
    end

    raise "You lose"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Raz")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
