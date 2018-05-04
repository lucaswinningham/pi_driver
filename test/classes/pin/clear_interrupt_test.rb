require_relative '../pin_test_helper'

class PinClearInterruptTest < PinTest
  def test_clear_interrupt
    thread = mock
    thread.stubs(:abort_on_exception=)
    Thread.expects(:new).returns(thread)
    pin = PiDriver::Pin.new @gpio_number
    pin.interrupt {}
    thread.expects(:kill)
    assert pin.clear_interrupt
  end

  def test_clear_interrupt_ignore_if_undefined
    pin = PiDriver::Pin.new @gpio_number
    assert_nil pin.clear_interrupt
  end
end
