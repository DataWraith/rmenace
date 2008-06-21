
# Add the implementation-files to the path
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
$:.unshift File.join(File.dirname(__FILE__), '..', 'bin')

# Add the spec-files to the path
$:.unshift File.join(File.dirname(__FILE__), 'grid')
$:.unshift File.join(File.dirname(__FILE__), 'players')

# Set the Random Number generator, so we get repeatable tests
srand(0x31415926535)

# helper-function for playing a game
def play_a_game(player1, player2)
  grid = TicTacToe::Grid.new

  while grid.gamestate == :ongoing
    player1.make_move(grid)
    player2.make_move(grid) unless grid.gamestate != :ongoing
  end

  player1.end_of_game(grid, :x) if player1.respond_to?(:end_of_game)
  player2.end_of_game(grid, :o) if player2.respond_to?(:end_of_game)

  return grid.gamestate
end
