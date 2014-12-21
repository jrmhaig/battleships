require 'battleships/grid'

# The Game of Battleships
class Battleships
  HORIZONTAL = 0
  VERTICAL = 1

  SHIPS = {
    destroyer: {
      length: 2,
      name: 'destroyer'
    },
    cruiser: {
      length: 3,
      name: 'cruiser'
    },
    submarine: {
      length: 3,
      name: 'submarine'
    },
    battleship: {
      length: 4,
      name: 'battleship'
    },
    aircraft_carrier: {
      length: 5,
      name: 'aircraft carrier'
    }
  }

  def self.ship_length(ship)
    SHIPS.key?(ship) ? SHIPS[ship][:length] : 0
  end

  def self.ship_name(ship)
    SHIPS.key?(ship) ? SHIPS[ship][:name] : 'unknown'
  end
end
