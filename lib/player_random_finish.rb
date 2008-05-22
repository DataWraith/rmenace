
require 'player_random.rb'

module TicTacToe

  class RandomFinishPlayer < RandomPlayer

    def name
      "Random Finish"
    end

    def select_move(grid)
      # Play randomly, but connect three if possible

      for i in grid.legal_moves
        grid.play(i)
        gamestate = grid.gamestate
        grid.undo

        if (gamestate == :x_wins) or (gamestate == :o_wins)
          return i
        end
      end
      return super(grid)
    end

  end

end
