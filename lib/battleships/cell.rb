require 'colorize'
require "battleships"

module Battleships
  class Cell # A cell on the battleships grid
    attr_reader :x, :y
    attr_accessor :content, :shot

    def initialize(x, y, content = nil)
      @x, @y, @content, @shot = x, y, content, false
    end

    def ==(other)
      other.class == self.class && @x == other.x && @y == other.y && @content == other.content
    end

    def symbol
      if @content
        if @content == :unknown and @shot
          '?'.colorize :red
        else
          ship_name(@content).chars.first.upcase.colorize(@shot ? :red : :blue)
        end
      else
        @shot ? '*'.colorize(:red) : '.'
      end
    end

    def hit
      @content, @shot = :unknown, true
    end
  end
end
