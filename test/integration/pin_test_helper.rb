require_relative '../integration_test_helper'

class IntegrationPinTest < IntegrationTest
  def setup
    super
    @active_low_writer = PiDriver::Pin.new 5
    @active_low_reader = PiDriver::Pin.new 6

    @active_high_writer = PiDriver::Pin.new 13
    @active_high_reader = PiDriver::Pin.new 19

    @active_low_writer.output 1
    @active_high_writer.output 0

    timeout { @active_low_reader.set? && @active_high_reader.clear? }
    assert @active_low_reader.set? && @active_high_reader.clear?
  end
end
