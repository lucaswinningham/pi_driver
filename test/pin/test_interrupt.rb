require_relative '../pin_test_helper'

class PinInterruptTest < PinTest
  def test_interrupt
    pin = PiDriver::Pin.new @pin_number
    interrupt = mock
    [:rising, :falling, :both, :none].each do |edge|
      PiDriver::Utils::Interrupt.expects(:new).with(edge).returns(interrupt)
      interrupt.expects(:start)
      pin.interrupt(edge)
    end
  end

  def test_interrupt_default
    pin = PiDriver::Pin.new @pin_number

    interrupt = sequence('interrupt default')
    expect_value_read(0).in_sequence(interrupt)
    expect_value_read(1).at_least_once.in_sequence(interrupt)

    interrupted = false

    pin.interrupt do |edge|
      assert :rising, edge
      interrupted = true
      pin.clear_interrupt
    end

    timeout { interrupted }
    assert interrupted
  end

  def test_interrupt_argument
    pin = PiDriver::Pin.new @pin_number

    interrupt = sequence('interrupt argument')
    expect_value_read(1).in_sequence(interrupt)
    expect_value_read(0).at_least_once.in_sequence(interrupt)

    interrupted = false

    pin.interrupt(:falling) do |edge|
      assert :falling, edge
      interrupted = true
      pin.clear_interrupt
    end

    timeout { interrupted }
    assert interrupted
  end
end
