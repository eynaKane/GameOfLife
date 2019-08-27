require 'pry'
load 'cell.rb'

# Maps the cells that are alive and dead
class Board
  attr_reader :board, :live_cells

  def initialize(live_cells)
    @live_cells = live_cells
    display(live_cells)
  end

  def dead_cells
    @dead_cells ||= []
  end

  def next_generation
    temp_live_cells = find_cells_to_keep_alive
    temp_live_cells += find_cells_to_resurrect

    live_cells = temp_live_cells
    # puts "NEW GENERATION: #{live_cells.sort}"

    live_cells
  end

  def find_cells_to_keep_alive
    keep_alive = []

    live_cells.each do |live_cell|
      cell = Cell.new(live_cell[0], live_cell[1])

      # SEPARATE LIVE AND DEAD NEIGHBORS OF A LIVE CELL
      cell.neighbors.each do |neighbor|
        if live_cells.include?(neighbor)
          cell.live_neighbors << neighbor
        else
          dead_cells << neighbor
        end
      end

      keep_alive << live_cell if cell.keep?
    end

    keep_alive
  end

  def find_cells_to_resurrect
    resurrect = []

    dead_cells.uniq!.each do |dead_cell|
      cell = Cell.new(dead_cell[0], dead_cell[1])

      # SEPARATE LIVE NEIGHBORS OF A DEAD CELL
      cell.neighbors.each do |neighbor|
        cell.live_neighbors << neighbor if live_cells.include?(neighbor)
      end

      resurrect << dead_cell if cell.resurrect?
    end

    resurrect
  end

  def display(live_cells)
    x = live_cells.map { |live_cell| live_cell[0] }
    y = live_cells.map { |live_cell| live_cell[1] }

    max_x = x.max
    min_y = y.min
    max_y = y.max

    while max_y >= min_y
      min_x = x.min
      while min_x <= max_x
        if live_cells.include?([min_x, max_y])
          print '0'
        else
          print ' '
        end
        min_x += 1
      end
      max_y -= 1
      puts
    end
  end
end
