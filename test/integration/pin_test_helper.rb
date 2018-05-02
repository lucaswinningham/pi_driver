require_relative '../integration_test_helper'

class IntegrationPinTest < IntegrationTest
  def setup
    @active_low_writer = PiDriver::Pin.new 5
    @active_low_reader = PiDriver::Pin.new 6

    @active_high_writer = PiDriver::Pin.new 13
    @active_high_reader = PiDriver::Pin.new 19
  end
end
