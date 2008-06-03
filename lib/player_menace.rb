
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
    end

  end
end
