
require File.dirname(__FILE__) + '/../lib/player_minimax.rb'
require File.dirname(__FILE__) + '/player_spec.rb'

describe "A perfect Minimax Player" do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::MinimaxPlayer.new
    @grid = TicTacToe::Grid.new
    [0, 1, 3, 4].each do |i|
      @grid.play(i)
    end
  end

  it "should connect three if possible" do
    @player.make_move(@grid)
    @grid.gamestate.should == :x_wins
  end

  it "should prevent the opponent from connecting three" do
    @grid.play(8)
    @grid.play(6)
    @player.make_move(@grid)
    @grid.history.last.should == 7
  end

end
