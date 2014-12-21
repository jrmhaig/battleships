require 'spec_helper'

RSpec.describe Battleships do
  describe 'ship_length' do
    it 'returns the length of a destroyer' do
      expect(Battleships.ship_length(:destroyer)).to eq 2
    end

    it 'returns the length of a cruiser' do
      expect(Battleships.ship_length(:cruiser)).to eq 3
    end

    it 'returns the length of a submarine' do
      expect(Battleships.ship_length(:submarine)).to eq 3
    end

    it 'returns the length of a battleship' do
      expect(Battleships.ship_length(:battleship)).to eq 4
    end

    it 'returns the length of an aircraft carrier' do
      expect(Battleships.ship_length(:aircraft_carrier)).to eq 5
    end

    it 'returns zero for the length of an unknown ship' do
      expect(Battleships.ship_length(:liner)).to eq 0
    end
  end

  describe 'ship_name' do
    it 'returns the name of a destroyer' do
      expect(Battleships.ship_name(:destroyer)).to eq 'destroyer'
    end

    it 'returns the name of a cruiser' do
      expect(Battleships.ship_name(:cruiser)).to eq 'cruiser'
    end

    it 'returns the name of a submarine' do
      expect(Battleships.ship_name(:submarine)).to eq 'submarine'
    end

    it 'returns the name of a battleship' do
      expect(Battleships.ship_name(:battleship)).to eq 'battleship'
    end

    it 'returns the name of a aircraft carrier' do
      expect(Battleships.ship_name(:aircraft_carrier)).to eq 'aircraft carrier'
    end

    it 'returns "unknown" for the name of an unknown ship' do
      expect(Battleships.ship_name(:liner)).to eq 'unknown'
    end
  end
end
