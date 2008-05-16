
require File.dirname(__FILE__) + '/../lib/player_center_random.rb'
require File.dirname(__FILE__) + '/player_spec.rb'

describe "A Player playing center when possible, randomly otherwise," do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::CenterRandomPlayer.new
  end

  it "should play into the center if that move is legal" do
    my_grid = TicTacToe::Grid.new
    @player.make_move(my_grid)
    my_grid.history.last.should == 4
  end

end
