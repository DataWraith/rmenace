
# Add the implementation-files to the path
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
$:.unshift File.join(File.dirname(__FILE__), '..', 'bin')

# Add the spec-files to the path
$:.unshift File.join(File.dirname(__FILE__), 'grid')
$:.unshift File.join(File.dirname(__FILE__), 'players')

# Seed the Pseudorandom number generator, so we get repeatable tests
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

# helper-function for playing a series of games
def play_multiple_games(number_of_games, player, opponent)

  score = 0

  (number_of_games/2).times do
    # player plays :x
    result = play_a_game(player, opponent)
    score += 3 if result == :x_wins
    score += 1 if result == :tie

    # player plays :o
    result = play_a_game(opponent, player)
    score += 3 if result == :o_wins
    score += 1 if result == :tie
  end

  return score

end
