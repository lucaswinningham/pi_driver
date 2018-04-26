require_relative '../pin_test_helper'

class PinClearInterruptTest < PinTest
  def test_clear_interrupt
    thread = mock
    thread.stubs(:abort_on_exception=)
    Thread.expects(:new).returns(thread)
    pin = PiDriver::Pin.new @gpio_number
    pin.interrupt {}
    thread.expects(:kill)
    pin.clear_interrupt
  end
end
