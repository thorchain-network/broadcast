require "test_helper"

class NodeChannelTest < ActionCable::Channel::TestCase
  test "subscribes and stream for network" do
    subscribe network: "mainnet"
    assert subscription.confirmed?
    assert_has_stream "mainnet"
  end
end
