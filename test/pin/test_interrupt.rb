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

  # def test_interrupt_both
  #   pin = PiDriver::Pin.new @pin_number

  #   interrupted = false
  #   both = sequence('both')
  #   expect_value_read('0').in_sequence(both)
  #   expect_value_read('1').at_least_once.in_sequence(both)
  #   pin.interrupt(:both) do
  #     interrupted = true
  #     pin.clear_interrupt
  #   end
  #   timeout { interrupted }
  #   assert interrupted

  #   interrupted = false
  #   both = sequence('both')
  #   expect_value_read('1').in_sequence(both)
  #   expect_value_read('0').at_least_once.in_sequence(both)
  #   pin.interrupt(:both) do
  #     interrupted = true
  #     pin.clear_interrupt
  #   end
  #   timeout { interrupted }
  #   assert interrupted
  # end
end
