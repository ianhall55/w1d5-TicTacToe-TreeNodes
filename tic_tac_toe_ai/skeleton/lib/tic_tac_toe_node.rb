require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.over? && (@board.winner == evaluator || @board.winner == nil)
    return true if @board.over? && !(@board.winner == evaluator)

    self.children.any? { |child| child.losing_node?(evaluator) }
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator
    return false if @board.over? && !(@board.winner == evaluator)

    self.children.any? { |child| child.winning_node?(evaluator) }
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_pos = []
    @board.rows.each_with_index do |row, idx|
      row.each_index do |col|
        pos = [idx, col]
        empty_pos << pos if @board.empty?(pos)
      end
    end

    next_mover = (@next_mover_mark == :x) ? :o : :x

    empty_pos.map do |pos|
      new_board = @board.dup
      new_board[pos] = next_mover_mark

      TicTacToeNode.new(new_board, next_mover, pos)
    end
  end
end
