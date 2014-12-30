require 'spec_helper'

RSpec.describe Battleships::Grid do
  describe 'initialize' do
    it 'creates a grid of the given width' do
      grid = Battleships::Grid.new(10, 10)
      expect(grid.width).to be 10
    end

    it 'creates a grid of the given height' do
      grid = Battleships::Grid.new(10, 10)
      expect(grid.height).to be 10
    end
  end

  describe 'add_ship' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'adds a horizontal ship in a valid position at the left edge of the grid' do
      expect(grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL)).to be_truthy
    end

    it 'adds a horizontal ship in a valid position at the right edge of the grid' do
      expect(grid.add_ship(6, 0, :battleship, Battleships::HORIZONTAL)).to be_truthy
    end

    it 'adds a vertical ship in a valid position at the top edge of the grid' do
      expect(grid.add_ship(0, 0, :battleship, Battleships::VERTICAL)).to be_truthy
    end

    it 'adds a vertical ship in a valid position at the bottom edge of the grid' do
      expect(grid.add_ship(0, 6, :battleship, Battleships::VERTICAL)).to be_truthy
    end

    it 'fails to add a ship off the right of the grid' do
      expect(grid.add_ship(7, 0, :battleship, Battleships::HORIZONTAL)).to be_falsy
    end

    it 'fails to add a ship off the left of the grid' do
      expect(grid.add_ship(-1, 0, :battleship, Battleships::HORIZONTAL)).to be_falsy
    end

    it 'fails to add a ship off the bottom of the grid' do
      expect(grid.add_ship(0, 7, :battleship, Battleships::VERTICAL)).to be_falsy
    end

    it 'fails to add a ship off the left of the grid' do
      expect(grid.add_ship(0, -1, :battleship, Battleships::VERTICAL)).to be_falsy
    end

    it 'adds the right number of cells' do
      expect { grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL) }.to change(grid.instance_variable_get(:@cells), :length).by Battleships.ship_length(:battleship)
    end

    it 'fails to add overlapping ships' do
      grid.add_ship(0, 1, :battleship, Battleships::HORIZONTAL)
      expect(grid.add_ship(1, 0, :destroyer, Battleships::VERTICAL)).to be_falsy
    end

    it 'fails to add a ship twice' do
      grid.add_ship(0, 1, :battleship, Battleships::HORIZONTAL)
      expect(grid.add_ship(0, 2, :battleship, Battleships::HORIZONTAL)).to be_falsy
    end
  end

  describe 'line_free?' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'indicates a horizontal line is free' do
      expect(grid.line_free?(0, 0, 5, Battleships::HORIZONTAL)).to be_truthy
    end

    it 'indicates a vertical line is free' do
      expect(grid.line_free?(0, 0, 5, Battleships::VERTICAL)).to be_truthy
    end

    it 'indicates a horizontal line is not free' do
      grid.add_ship(1, 0, :battleship, Battleships::VERTICAL)
      expect(grid.line_free?(0, 1, 5, Battleships::HORIZONTAL)).to be_falsy
    end

    it 'indicates a vertical line is not free' do
      grid.add_ship(0, 1, :battleship, Battleships::HORIZONTAL)
      expect(grid.line_free?(1, 0, 5, Battleships::VERTICAL)).to be_falsy
    end
  end

  describe 'get_cell' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'returns a live cell' do
      grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL)
      expect(grid.get_cell(2, 0)).to eq Battleships::Cell.new(2, 0, :battleship)
    end

    it 'returns an empty cell' do
      expect(grid.get_cell(2, 0)).to eq Battleships::Cell.new(2, 0, nil)
    end
  end

  describe 'fire' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'hits a ship' do
      grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL)
      expect(grid.fire(1, 0)).to eq :battleship
    end

    it 'misses a ship' do
      expect(grid.fire(1, 0)).to eq nil
    end

    it 'fails to fire at a cell twice' do
      grid.fire(1, 0)
      expect(grid.fire(1, 0)).to eq false
    end
  end

  describe 'hit' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'registers a hit' do
      grid.hit(1, 1)
      c = grid.get_cell(1, 1)
      expect(c.shot).to be true
      expect(c.content).to be :unknown
    end

  end

  describe 'miss' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'registers a miss' do
      grid.miss(1, 1)
      c = grid.get_cell(1, 1)
      expect(c.shot).to be true
      expect(c.content).to be nil
    end
  end

  describe 'get_ship' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'finds all cells of a ship' do
      grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL)
      expect(grid.get_ship(:battleship)).to eq [
        Battleships::Cell.new(0, 0, :battleship),
        Battleships::Cell.new(1, 0, :battleship),
        Battleships::Cell.new(2, 0, :battleship),
        Battleships::Cell.new(3, 0, :battleship)
      ]
    end
  end

  describe 'destroyed?' do
    let(:grid) { Battleships::Grid.new(10, 10) }

    it 'reports a destroyed ship (true)' do
      grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL)
      (0..3).each { |x| grid.get_cell(x, 0).shot = true }
      expect(grid.destroyed?(:battleship)).to be true
    end

    it 'reports a non destroyed ship (false)' do
      grid.add_ship(0, 0, :battleship, Battleships::HORIZONTAL)
      (0..2).each do |x|
        grid.get_cell(x, 0).shot = true
        expect(grid.destroyed?(:battleship)).to be false
      end
    end
  end
end
