
require 'player_random.rb'

module TicTacToe

  class MENACE < RandomPlayer

    INITIAL_BEADS = 20

    def name
      "MENACE"
    end

    def initialize
      @matchboxes = Hash.new
    end

    def select_move(grid)

      # First we select a permutation.
      perm = get_permutation(grid)

      # Using that permutation on the current grid, gives us the 'canonical'
      # grid of the current position. The 'canonical' grid is the one with the
      # smallest hash in all grids that are equivalent to the current one under
      # rotation/reflection.

      canonical_grid = get_canonical_grid(grid, perm)

      # Now we look the position up in our matchboxes-hash
      if @matchboxes.include?(canonical_grid)
        # We have previously encountered this game position. We can choose a
        # move weighted by previous experience.

        # Count all beads in the matchbox
        sum = 0
        @matchboxes[canonical_grid].each { |i| sum += i }

        # Choose randomly among the beads
        bead_number = rand(sum)

        # Find the move that bead advocates
        for i in (0..8)
          # Subtract number of beads advocating move i

          bead_number -= @matchboxes[canonical_grid][i]

          # If we reached zero, the bead we chose randomly was advocating move i
          if bead_number <= 0
            # Now we know the move we want to make on the 'canonical' grid.

            # We now need to find the move in our actual grid that corresponds
            # to that move.
            for move in grid.legal_moves
              return move if perm[move] == i
            end
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

      my_grid = Grid.new

      # Go through the game and adjust matchboxes
      for i in grid.history

        if my_grid.to_move == i_played
          perm = get_permutation(my_grid)
          canonical_grid = get_canonical_grid(my_grid, perm)

          # Prepare a matchbox if we don't have one yet
          unless @matchboxes.include?(canonical_grid)
            matchbox = [0]*9
            for move in my_grid.legal_moves
              matchbox[move] = INITIAL_BEADS
            end

            @matchboxes[canonical_grid] = matchbox
          end

          # Find the move we actually made and adjust its bead-count
          bead_count = @matchboxes[canonical_grid][perm[i]]
          bead_count = [1, bead_count + modifier].max
          @matchboxes[canonical_grid][perm[i]] = bead_count
        end

        my_grid.play(i)
      end

    end

    private

    PERMUTATIONS = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8], # Do nothing
      [6, 3, 0, 7, 4, 1, 8, 5, 2], # Rotate 90° clockwise
      [8, 7, 6, 5, 4, 3, 2, 1, 0], # Rotate 180°
      [2, 5, 8, 1, 4, 7, 0, 3, 6], # Rotate 270° clockwise
      [2, 1, 0, 5, 4, 3, 8, 7, 6], # Mirror
      [8, 5, 2, 7, 4, 1, 6, 3, 0], # Rotate Mirror 90° clockwise
      [6, 7, 8, 3, 4, 5, 0, 1, 2], # Rotate Mirror 180°
      [0, 3, 6, 1, 4, 7, 2, 5, 8]  # Rotate Mirror 270° clockwise
    ]

    def get_permutation(grid)

      result = []
      smallest_hash = 1.0 / 0.0 # Infinity

      PERMUTATIONS.each do |perm|
        permuted_array = []
        perm.each do |f|
          permuted_array.push(grid.fields[f])
        end

        if permuted_array.hash < smallest_hash
          smallest_hash = permuted_array.hash
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

  end
end
