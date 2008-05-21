
require File.dirname(__FILE__) + '/../lib/player_simple_learner.rb'
require File.dirname(__FILE__) + '/player_spec.rb'

describe "A simple learning Player" do

  it_should_behave_like "A Player"

  before(:each) do
    @player = TicTacToe::SimpleLearner.new
  end

end
