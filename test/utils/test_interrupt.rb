require_relative '../utils_test_helper'

class UtilsInterruptTest < UtilsTest
  def test_new_default
    interrupt = PiDriver::Utils::Interrupt.new(:some_edge) { [0, 1].sample }
    Thread.expects(:new).twice
    interrupt.start
    interrupt.start { 'test block' }
  end

  def test_rising
    value_object = mock
    interrupt = PiDriver::Utils::Interrupt.new(:rising) { value_object.value_method }
    interrupted = false
    rising = sequence('rising')
    value_object.expects(:value_method).returns(0).in_sequence(rising)
    value_object.expects(:value_method).returns(1).at_least_once.in_sequence(rising)
    interrupt.start do
      interrupted = true
      interrupt.clear
    end
    timeout { interrupted }
    assert interrupted
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

  # def test_interrupt_none
  #   pin = PiDriver::Pin.new @pin_number

  #   interrupted = false
  #   none = sequence('none')
  #   expect_value_read('0').in_sequence(none)
  #   expect_value_read('1').at_least_once.in_sequence(none)
  #   pin.interrupt(:none) { interrupted = true }
  #   timeout { interrupted }
  #   refute interrupted
  #   pin.clear_interrupt

  #   interrupted = false
  #   none = sequence('none')
  #   expect_value_read('1').in_sequence(none)
  #   expect_value_read('0').at_least_once.in_sequence(none)
  #   pin.interrupt(:none) { interrupted = true }
  #   timeout { interrupted }
  #   refute interrupted
  #   pin.clear_interrupt
  # end
end