require_relative '../integration_test_helper'

# for all integration pin tests, connect pins 3 and 5 together
class IntegrationPinTest < IntegrationTest
  def setup
    @setter = PiDriver::Pin.new 2, direction: :out
    @getter = PiDriver::Pin.new 3
  end
end
