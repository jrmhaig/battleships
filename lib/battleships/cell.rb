require 'colorize'

class Battleships
  # A cell on the battleships grid
  class Cell
    attr_reader :x
    attr_reader :y
    attr_accessor :content
    attr_accessor :shot

    def initialize(x, y, content = nil)
      @x = x
      @y = y
      @content = content
      @shot = false
    end

    def ==(other)
      other.class == Battleships::Cell && @x == other.x && @y == other.y && @content == other.content
    end

    def symbol
      if @content
        if @content == :unknown and @shot == true
          '?'.colorize(:red)
        else
          Battleships.ship_name(@content).chars.first.upcase.colorize(@shot ? :red : :blue)
        end
      else
        @shot ? '*'.colorize(:red) : '.'
      end
    end

    def hit
      @content = :unknown
      @shot = true
    end
  end
end
