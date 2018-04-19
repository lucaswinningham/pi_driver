require_relative '../integration_test_helper'

# for all integration pin tests, connect pins 11 and 12 together
class IntegrationPinTest < IntegrationTest
  def setup
    @setter = PiDriver::Pin.new 0, direction: :out
    @getter = PiDriver::Pin.new 1
  end
end
