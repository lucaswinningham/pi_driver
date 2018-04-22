require_relative '../integration_test_helper'

# NOTE: for all integration pin tests, connect pins 16 and 18 together
class IntegrationPinTest < IntegrationTest
  def setup
    @setter = PiDriver::Pin.new 23, direction: :out
    @getter = PiDriver::Pin.new 24
  end
end
