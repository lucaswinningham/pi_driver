require_relative '../pin_test_helper'

class PinInterruptTest < PinTest
  def test_interrupt
    pin = PiDriver::Pin.new @pin_number
    interrupt = mock

    %i[rising falling both none].each do |edge|
      PiDriver::Utils::Interrupt.expects(:new).with(edge).returns(interrupt)
      interrupt.expects(:start)
      pin.interrupt(edge)
    end
  end

  def test_interrupt_default
    pin = PiDriver::Pin.new @pin_number
    interrupt_default = sequence('interrupt default')
    expect_value_read(0).in_sequence(interrupt_default)
    expect_value_read(1).at_least_once.in_sequence(interrupt_default)

    interrupted = false
    pin.interrupt { interrupted = true }

    timeout { interrupted }
    assert interrupted

    pin.clear_interrupt
  end

  def test_interrupt_argument
    pin = PiDriver::Pin.new @pin_number
    interrupt_argument = sequence('interrupt argument')
    expect_value_read(1).in_sequence(interrupt_argument)
    expect_value_read(0).at_least_once.in_sequence(interrupt_argument)

    interrupted = false
    pin.interrupt(:falling) { interrupted = true }

    timeout { interrupted }
    assert interrupted

    pin.clear_interrupt
  end
end
