
require 'player.rb'

module TicTacToe

  class MENACE < Player

    def name
      "MENACE"
    end

    def select_move(grid)
      super(grid)
    end

    def end_of_game(grid)

      # Error checking
      super(grid)

      # Do the actual learning

      # TODO: Do the actual learning. :P
    end

  end
end
