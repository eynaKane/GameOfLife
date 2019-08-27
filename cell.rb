require 'pry'

# Determines cell status and neighbors
class Cell
  attr_reader :cell_x, :cell_y

  def initialize(cell_x = 0, cell_y = 0)
    @cell_x = cell_x
    @cell_y = cell_y
  end

  def keep?
    live_neighbors_count == 2 || live_neighbors_count == 3
  end

  def resurrect?
    live_neighbors_count == 3
  end

  def live_neighbors
    @live_neighbors ||= []
  end

  def live_neighbors_count
    @live_neighbors_count ||= live_neighbors.count
  end

  def neighbors
    neighbor_coordinates = []
    x_coordinates = get_coordinates(cell_x)
    y_coordinates = get_coordinates(cell_y)

    x_coordinates.each do |x_coordinate|
      y_coordinates.each do |y_coordinate|
        neighbor_coordinates << [x_coordinate, y_coordinate]
      end
    end

    neighbor_coordinates - [[cell_x, cell_y]]
  end

  def get_coordinates(axis)
    [axis, axis - 1, axis + 1]
  end
end
