# [[1, 8], [2, 8], [2, 10], [3, 8], [3, 9]]
# [[6, 8], [6, 9], [7, 7], [7, 9], [7, 10], [8, 8], [8, 9]]
require 'pry'
load 'board.rb'

# Conway's Game of Life
class GameOfLife
  attr_reader :board, :live_cells

  def initialize(live_cells)
    @board = Board.new(live_cells)
  end

  def perform
    @live_cells = board.next_generation

    print 'Next? (y or n): '
    answer = gets.rstrip
    GameOfLife.new(live_cells).perform if answer == 'y'
  end
end

print "Welcome to the Game of Life.\nInitialize: "
# rubocop:disable Security/Eval
live_cells = eval(gets.rstrip)
# rubocop:enable Security/Eval

GameOfLife.new(live_cells).perform

puts "\nThat is the Game of Life. Goodbye!"
