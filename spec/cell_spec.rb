require 'spec_helper'
require 'colorize'

RSpec.describe Battleships::Cell do
  describe 'hit' do
    it 'marks an unknown cell as hit' do
      c = Battleships::Cell.new(1, 1)
      c.hit
      expect(c.shot).to eq true
      expect(c.content).to eq :unknown
    end
  end

  describe 'symbol' do
    it 'returns the symbol of a destroyer' do
      expect(Battleships::Cell.new(1, 1, :destroyer).symbol).to eq 'D'.colorize(:blue)
    end

    it 'returns the symbol of a cruiser' do
      expect(Battleships::Cell.new(1, 1, :cruiser).symbol).to eq 'C'.colorize(:blue)
    end

    it 'returns the symbol of a submarine' do
      expect(Battleships::Cell.new(1, 1, :submarine).symbol).to eq 'S'.colorize(:blue)
    end

    it 'returns the symbol of a battleship' do
      expect(Battleships::Cell.new(1, 1, :battleship).symbol).to eq 'B'.colorize(:blue)
    end

    it 'returns the symbol of a aircraft carrier' do
      expect(Battleships::Cell.new(1, 1, :aircraft_carrier).symbol).to eq 'A'.colorize(:blue)
    end

    it 'returns "." for the symbol of an empty cell' do
      expect(Battleships::Cell.new(1, 1).symbol).to eq '.'
    end

    it 'returns the symbol of a shot destroyer' do
      c = Battleships::Cell.new(1, 1, :destroyer)
      c.shot = true
      expect(c.symbol).to eq 'D'.colorize(:red)
    end

    it 'returns the symbol of a shot cruiser' do
      c = Battleships::Cell.new(1, 1, :cruiser)
      c.shot = true
      expect(c.symbol).to eq 'C'.colorize(:red)
    end

    it 'returns the symbol of a shot submarine' do
      c = Battleships::Cell.new(1, 1, :submarine)
      c.shot = true
      expect(c.symbol).to eq 'S'.colorize(:red)
    end

    it 'returns the symbol of a shot battleship' do
      c = Battleships::Cell.new(1, 1, :battleship)
      c.shot = true
      expect(c.symbol).to eq 'B'.colorize(:red)
    end

    it 'returns the symbol of a shot aircraft carrier' do
      c = Battleships::Cell.new(1, 1, :aircraft_carrier)
      c.shot = true
      expect(c.symbol).to eq 'A'.colorize(:red)
    end

    it 'returns the symbol of a shot unknown ship' do
      c = Battleships::Cell.new(1, 1)
      c.hit
      expect(c.symbol).to eq '?'.colorize(:red)
    end

    it 'returns "." for the symbol of a shot cell' do
      c = Battleships::Cell.new(1, 1)
      c.shot = true
      expect(c.symbol).to eq '*'.colorize(:red)
    end
  end
end
