require "battleships"
require "battleships/cell"

module Battleships
  # The battleships grid
  class Grid
    attr_reader :width, :height

    def initialize(width, height)
      @cells, @width, @height = Array.new, width, height
    end

    def add_ship(x, y, ship, orientation)
      l = ship_length(ship)
      return false if l <= 0 || x < 0 || y < 0 || !line_free?(x, y, l, orientation) || (orientation == HORIZONTAL && x + l > @width) || (orientation ==VERTICAL && y + l > @height) || get_ship(ship).length > 0

      @cells.concat(
        (0..(l - 1)).collect do |z|
          Cell.new(
            orientation == HORIZONTAL ? x + z : x,
            orientation == HORIZONTAL ? y : y + z,
            ship
          )
        end
      )
    end

    # Indicate if a horizontal or vertical line is clear
    def line_free?(x, y, length, orientation)
      if orientation == HORIZONTAL
        (x..(x + length - 1)).each do |z|
          return false if get_cell(z, y).content
        end
      elsif orientation == VERTICAL
        (y..(y + length - 1)).each do |z|
          return false if get_cell(x, z).content
        end
      end
      true
    end

    # Return the cell at a particular position
    # If the cell does not exist, create a cell with nil content
    def get_cell(x, y)
      @cells.select { |c| c.x == x && c.y == y }.first || Cell.new(x, y, nil)
    end

    # Return all the cells of a particular ship
    def get_ship(ship)
      @cells.select { |c| c.content == ship }
    end

    # Shoot a cell
    # Returns:
    #   - Content of the cell (ship symbol or nil)
    #   - False if the cell has already been shot
    def fire(x, y)
      c = get_cell(x, y)
      if c.shot then false
      else
        c.shot = true
        @cells << c unless @cells.include?(c)
        c.content
      end
    end

    def hit(x, y)
      c = get_cell x, y
      c.shot, c.content = true, :unknown
      @cells << c unless @cells.include?(c)
    end

    def miss(x, y)
      c, c.shot = get_cell(x, y), true
      @cells << c unless @cells.include?(c)
    end

    # Indicate whether a ship has been destroyed or not
    def destroyed?(ship)
      get_ship(ship).select { |c| c.shot == true }.length == ship_length(ship)
    end
  end
end
