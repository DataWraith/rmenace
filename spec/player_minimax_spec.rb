
require File.dirname(__FILE__) + '/../lib/player_minimax.rb'
require File.dirname(__FILE__) + '/player_spec.rb'

describe "A perfect Minimax Player" do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::MinimaxPlayer.new
  end

  it "should connect three if possible"

  it "should prevent the opponent from connecting three"

end
