
require 'player_random.rb'

module TicTacToe

  class CenterRandomPlayer < RandomPlayer

    def name
      "Center Random"
    end

    def select_move(grid)
      # Play center when possible, otherwise play randomly
      if grid.fields[4] == :empty
	return 4
      else
	return super(grid)
      end
    end

  end

end
