require 'battleships'
require 'battleships/cell'

class Battleships
  # The battleships grid
  class Grid
    attr_reader :width
    attr_reader :height

    def initialize(width, height)
      @cells = []
      @width = width
      @height = height
    end

    def add_ship(x, y, ship, orientation)
      l = Battleships.ship_length(ship)
      return false if l <= 0 || x < 0 || y < 0 || !line_free?(x, y, l, orientation) || (orientation == Battleships::HORIZONTAL && x + l > @width) || (orientation == Battleships::VERTICAL && y + l > @height) || get_ship(ship).length > 0

      @cells.concat(
        (0..(l - 1)).collect do |z|
          Battleships::Cell.new(
            orientation == Battleships::HORIZONTAL ? x + z : x,
            orientation == Battleships::HORIZONTAL ? y : y + z,
            ship
          )
        end
      )
    end

    # Indicate if a horizontal or vertical line is clear
    def line_free?(x, y, length, orientation)
      if orientation == Battleships::HORIZONTAL
        (x..(x + length - 1)).each do |z|
          return false if get_cell(z, y).content
        end
      elsif orientation == Battleships::VERTICAL
        (y..(y + length - 1)).each do |z|
          return false if get_cell(x, z).content
        end
      end
      true
    end

    # Return the cell at a particular position
    # If the cell does not exist, create a cell with nil content
    def get_cell(x, y)
      @cells.select { |c| c.x == x && c.y == y }.first || Battleships::Cell.new(x, y, nil)
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
      if c.shot
        false
      else
        c.shot = true
        @cells << c if !@cells.include?(c)
        c.content
      end
    end

    def hit(x, y)
      c = get_cell(x, y)
      c.shot = true
      c.content = :unknown
      @cells << c if !@cells.include?(c)
    end

    def miss(x, y)
      c = get_cell(x, y)
      c.shot = true
      @cells << c if !@cells.include?(c)
    end

    # Indicate whether a ship has been destroyed or not
    def destroyed?(ship)
      get_ship(ship).select { |c| c.shot == true }.length == Battleships.ship_length(ship)
    end
  end
end
