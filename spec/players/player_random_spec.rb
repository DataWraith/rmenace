
require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

require 'player_random.rb'
require 'player_spec.rb'

describe "A Player making random moves" do

  it_should_behave_like "A Player"

  it "should be named 'Random'" do
    @player.name.should == "Random"
  end

  before(:each) do
    @player = TicTacToe::RandomPlayer.new
  end

end
