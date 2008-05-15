
require File.dirname(__FILE__) + '/../lib/player_random.rb'
require File.dirname(__FILE__) + '/player_spec.rb'

describe "A Player making random moves" do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::RandomPlayer.new
  end

end
