
require 'player_random.rb'

module TicTacToe

  class MENACE < RandomPlayer

    def name
      "MENACE"
    end

    def initialize
      @matchboxes = Hash.new
    end

    def select_move(grid)

      # First we select a permutation.
      perm = get_permutation(grid)

      # Using that permutation on the current grid gives us the 'canonical'
      # grid of the current position. The 'canonical' grid is the one that,
      # converted to a string, is the smallest when compared to all other grids
      # that are equivalent under rotation/reflection.

      canonical_grid = get_canonical_grid(grid, perm)

      # Now we look the position up in our matchboxes-hash
      if @matchboxes.include?(canonical_grid)
        # We have previously encountered this game position. We can choose a
        # move weighted by previous experience.

        # Count all beads in the matchbox
        sum = @matchboxes[canonical_grid].inject { |sum, beads| sum + beads }

        # Choose randomly among the beads
        bead_number = rand(sum)

        # Find the move the chosen bead advocates
        for i in (0..8)
          # Subtract number of beads advocating move i

          bead_number -= @matchboxes[canonical_grid][i]

          # If we reached zero, the bead we chose randomly was advocating move i
          if bead_number < 0
            # Now we know the move we want to make on the 'canonical' grid.

            # We now need to find the move in our actual grid that corresponds
            # to that move.
            for move in grid.legal_moves
              return move if perm[move] == i
            end
            raise "No move found, after determining that a move must exist."
          end
        end

      else
        # Position not found -> move randomly
        return super(grid)
      end
    end

    def end_of_game(grid, i_played)

      # Error checking
      super(grid, i_played)

      # Can't learn anything useful from a tie, so return.
      return if grid.gamestate == :tie

      # Did I win or lose?
      if ((grid.gamestate == :x_wins) and (i_played == :x)) or
         ((grid.gamestate == :o_wins) and (i_played == :o))
        modifier = 1
      else
        modifier = -1
      end

      replay_grid = Grid.new

      # Go through the game and adjust matchboxes
      for i in grid.history

        if replay_grid.to_move == i_played
          perm = get_permutation(replay_grid)
          canonical_grid = get_canonical_grid(replay_grid, perm)

          # Prepare a matchbox if we don't have one yet
          @matchboxes[canonical_grid] ||= make_matchbox(canonical_grid);

          # Find the move we actually made and adjust its bead-count
          @matchboxes[canonical_grid][perm[i]] += modifier

          # If MENACE has learned that all moves for this gamestate are bad,
          # reset the learning. If all moves really are bad, this won't make
          # a difference, but if they're not, starting from scratch gives us
          # another chance at learning the correct values.
          if @matchboxes[canonical_grid] == [0]*9
            @matchboxes[canonical_grid] = make_matchbox(canonical_grid)
          end

        end

        replay_grid.play(i)
      end

    end

    private

    PERMUTATIONS = [
      # Rotations (clockwise)
      [0, 1, 2, 3, 4, 5, 6, 7, 8], # 0°
      [2, 5, 8, 1, 4, 7, 0, 3, 6], # 90°
      [8, 7, 6, 5, 4, 3, 2, 1, 0], # 180°
      [6, 3, 0, 7, 4, 1, 8, 5, 2], # 270°
      # Mirror + Rotations (clockwise)
      [2, 1, 0, 5, 4, 3, 8, 7, 6], # 0°
      [8, 5, 2, 7, 4, 1, 6, 3, 0], # 90°
      [6, 7, 8, 3, 4, 5, 0, 1, 2], # 180°
      [0, 3, 6, 1, 4, 7, 2, 5, 8]  # 270°
    ]

    def get_permutation(grid)

      result = PERMUTATIONS[0]
      best_sofar = grid.to_s

      PERMUTATIONS.each do |perm|
        permuted_array = []
        perm.each do |f|
          permuted_array.push(grid.fields[f])
        end

        if permuted_array.to_s < best_sofar
          best_sofar = permuted_array.to_s
          result = perm
        end
      end

      return result
    end

    def  get_canonical_grid(grid, permutation)
      canonical_grid = []

      permutation.each do |i|
        canonical_grid.push(grid.fields[i])
      end

      return canonical_grid
    end

    def make_matchbox(grid_fields)
      # Find the number of legal moves by counting empty fields
      num_legal_moves = grid_fields.inject(0) do |num, field|
        if field == :empty
          num + 1
        else
          num
        end
      end

      # Make the matchbox
      matchbox = grid_fields.map do |square|
        if square == :empty
          num_legal_moves
        else
          0
        end
      end

      return matchbox
    end

  end
end
