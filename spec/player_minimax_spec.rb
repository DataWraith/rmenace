
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

  it "should connect three if possible (playing X)" do
    @player.make_move(@grid)
    @grid.history.last.should == 6
  end

  it "should connect three if possible (playing O)" do
    @grid.play(8)
    @player.make_move(@grid)
    @grid.history.last.should == 7
  end

  it "should prevent the opponent from connecting three (playing X)" do
    @grid.play(8)
    @grid.play(6)
    @player.make_move(@grid)
    @grid.history.last.should == 7
  end

  it "should prevent the opponent from connecting three (playing O)" do
    @grid.play(7)
    @player.make_move(@grid)
    @grid.history.last.should == 6
  end

end
