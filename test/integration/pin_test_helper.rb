require_relative '../integration_test_helper'

# TODO: figure out test circuit that enables testing of output high
class IntegrationPinTest < IntegrationTest
  def setup
    @setter = PiDriver::Pin.new 5, direction: :out
    @getter = PiDriver::Pin.new 6
  end
end
