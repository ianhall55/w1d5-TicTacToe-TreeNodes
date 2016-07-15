require_relative "node"
require 'byebug'

class KnightPathFinder
  attr_reader :start_pos

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
  end

  def self.valid_moves(pos)
    x,y = pos
    possible_moves = [[x+1, y+2], [x+2, y+1], [x+2, y-1], [x+1,y-2],
                     [x-1, y-2], [x-2,y-1], [x-2,y+1], [x-1,y+2]]
    possible_moves.select do |pos|
      pos[0].between?(0,9) && pos[1].between?(0,9)
    end
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos).reject { |pos| @visited_positions.include?(pos) }
  end

  def build_move_tree
    start_node = PolyTreeNode.new(@start_pos)
    move_tree = []
    queue = [start_node]
    until queue.empty?
      node = queue.shift
      move_tree << node
      new_move_positions(node.value).each do |pos|
        @visited_positions << pos
        new_node = PolyTreeNode.new(pos)
        new_node.parent = node
        queue << new_node
      end
    end
    @visited_positions.clear
# @visited_positions is necessary to reset the instance variable for two
# runs
    move_tree
  end

  def find_path(end_pos)
    # byebug

    move_tree = build_move_tree
    end_node = move_tree.first.dfs(end_pos)
    best_move = []
    current_node = end_node
    until current_node.parent == nil
      best_move << current_node.value
      current_node = current_node.parent
    end
    best_move << current_node.value
    best_move.reverse
  end
end

kfp = KnightPathFinder.new([0,0])
p kfp.find_path([7,6])
p kfp.find_path([6,2])
