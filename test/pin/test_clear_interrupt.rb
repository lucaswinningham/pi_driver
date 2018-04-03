require_relative '../pin_test_helper'

class PinClearInterruptTest < PinTest
  def test_clear_interrupt
    pin = PiDriver::Pin.new @pin_number
    interrupt_thread = pin.interrupt
    interrupt_thread.expects(:kill)
    pin.clear_interrupt
  end
end
