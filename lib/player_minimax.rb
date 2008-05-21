
require File.dirname(__FILE__) + '/player.rb'

module TicTacToe

  class MinimaxPlayer < Player

    def name
      "MiniMax"
    end

    def select_move(grid)

      move_eval = []

      for i in grid.legal_moves.clone do
        grid.play(i)
        move_eval += [[minimax(grid), i]] # [move value, move number]
        grid.undo
      end

      if grid.to_move == :x
        return move_eval.max.last
      else
        return move_eval.min.last
      end

    end

    def evaluate(grid)
      case grid.gamestate
      when :tie
        return 0

      when :x_wins
        return 10 - grid.move_nr        # Prefer fast victory over slow victory

      when :o_wins
        return -10 + grid.move_nr       # Prefer slow loss over fast loss
      end
    end

    def minimax(grid)
      if grid.gamestate != :ongoing
        return evaluate(grid)
      end

      move_eval = []
      for i in grid.legal_moves.clone
        grid.play(i)
        move_eval += [[minimax(grid), i]]
        grid.undo
      end

      if grid.to_move == :x
        return move_eval.max.first
      else
        return move_eval.min.first
      end
    end

  end

end
