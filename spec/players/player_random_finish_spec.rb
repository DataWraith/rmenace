
require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

require 'player_random_finish.rb'
require 'player_spec.rb'

describe "A Player making random moves, but connecting three if possible," do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::RandomFinishPlayer.new
  end

  it "should be named 'Random Finish'" do
    @player.name.should == "Random Finish"
  end

  it "should connect three if possible" do
    grid = TicTacToe::Grid.new
    [0, 1, 3, 4].each do |i|
      grid.play(i)
    end

    @player.make_move(grid)
    grid.gamestate.should == :x_wins
  end

end
