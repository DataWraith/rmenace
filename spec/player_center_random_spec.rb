
require File.dirname(__FILE__) + '/../lib/player_center_random.rb'
require File.dirname(__FILE__) + '/player_spec.rb'

describe "A Player playing center when possible, randomly otherwise," do

  before(:each) do
    @player = TicTacToe::CenterRandomPlayer.new
  end

  it_should_behave_like "A Player"

  it "should play into the center if that move is legal"

end
