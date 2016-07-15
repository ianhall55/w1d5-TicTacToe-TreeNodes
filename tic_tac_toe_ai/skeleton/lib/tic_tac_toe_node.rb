require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

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
    empty_pos = []
    @board.each_with_index do |row, idx|
      row.each_index do |col|
        pos = [idx, col]
        empty_pos << pos if @board.empty?(pos)
      end
    end

    empty_pos.map do |pos|
      new_board = @board.dup
      new_board[pos] = next_mover_mark
      next_mover_mark = (next_mover_mark == :x) ? :o : :x
      TicTacToeNode.new(new_board, next_mover_mark)
  end
end
