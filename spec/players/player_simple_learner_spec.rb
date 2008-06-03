
require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

require 'player_simple_learner.rb'
require 'player_spec.rb'

describe "A simple learning Player" do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::SimpleLearner.new
  end

  it "should be named 'Simple Learner'" do
    @player.name.should == "Simple Learner"
  end

end
