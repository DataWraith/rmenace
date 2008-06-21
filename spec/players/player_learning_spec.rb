
require 'player'

describe 'A learning Player', :shared => true do

  it_should_behave_like 'A Player'

  it "should improve after playing against Player" do

    opponent = TicTacToe::Player.new
    comparison_score = 0
    learned_score = 0

    # First batch of matches
    50.times do
      # @player plays :x
      result = play_a_game(@player, opponent)
      comparison_score += 3 if result == :x_wins
      comparison_score += 1 if result == :tie

      # @player plays :o
      result = play_a_game(opponent, @player)
      comparison_score += 3 if result == :o_wins
      comparison_score += 1 if result == :tie
    end

    # Second batch of matches
    50.times do
      # @player plays :x
      result = play_a_game(@player, opponent)
      learned_score += 3 if result == :x_wins
      learned_score += 1 if result == :tie

      # @player plays :o
      result = play_a_game(opponent, @player)
      learned_score += 3 if result == :o_wins
      learned_score += 1 if result == :tie
    end

    learned_score.should >= comparison_score
  end

end

