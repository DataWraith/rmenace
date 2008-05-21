
require File.dirname(__FILE__) + '/player_random.rb'

module TicTacToe

  class SimpleLearner < RandomPlayer

    def name
      "Simple Learner"
    end

    def initialize
      @x_wins = []
      @o_wins = []
    end

    def select_move(grid)

      if grid.to_move == :x
        i_win = @x_wins
        op_wins = @o_wins
      else
        i_win = @o_wins
        op_wins = @x_wins
      end

      available_moves = []

      # Is there a winning sequence for me?
      i_win.each do |move_sequence|
        if move_sequence[0...grid.move_nr] == grid.history
          # Yes! Use it.
          available_moves += [move_sequence[grid.move_nr]]
        end
      end

      if available_moves.empty?
        # No known winning sequence. Let's see if we can thwart the opponent

        available_moves = grid.legal_moves.clone

        # Is there a winning sequence for my opponent?
        op_wins.each do |move_sequence|
          if move_sequence[0...grid.move_nr] == grid.history
            # Yes. Try to thwart it by not choosing the next move in that
            # sequence
            available_moves.delete(move_sequence[grid.move_nr])
          end
        end

        # Any moves remaining that don't allow the opponent to win?
        if available_moves.empty?
          # If not, we just pick a random legal move
          available_moves = grid.legal_moves.clone
        end

      end

      # Choose one of the available moves at random
      available_moves.sort! { rand(3) - 1 }

      return available_moves.first
    end

    def end_of_game(grid)
      if grid.gamestate == :x_wins
        @x_wins |= [grid.history]
      elsif grid.gamestate == :o_wins
        @o_wins |= [grid.history]
      end
    end

  end

end

