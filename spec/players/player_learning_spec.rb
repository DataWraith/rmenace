
require 'player'

describe 'A learning Player', :shared => true do

  it_should_behave_like 'A Player'

  it "should improve after playing against Player" do
    opponent = TicTacToe::Player.new
    comparison_score = 0
    learned_score = 0

    # First batch of matches
    comparison_score = play_multiple_games(100, @player, opponent)

    # Second batch of matches
    learned_score = play_multiple_games(100, @player, opponent)

    learned_score.should >= comparison_score
  end

end

