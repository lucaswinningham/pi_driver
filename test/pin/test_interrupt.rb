# require_relative '../pin_test_helper'

# class PinInterruptTest < PinTest
#   def test_interrupt
#     pin = PiDriver::Pin.new @pin_number
#     Thread.expects(:new).twice
#     pin.interrupt
#     pin.interrupt { 'test block' }
#   end

#   def test_interrupt_rising
#     pin = PiDriver::Pin.new @pin_number
#     interrupted = false
#     rising = sequence('rising')
#     expect_value_read('0').in_sequence(rising)
#     expect_value_read('1').at_least_once.in_sequence(rising)
#     pin.interrupt(:rising) do
#       interrupted = true
#       pin.clear_interrupt
#     end
#     timeout { interrupted }
#     assert interrupted
#   end

#   def test_interrupt_falling
#     pin = PiDriver::Pin.new @pin_number
#     interrupted = false
#     falling = sequence('falling')
#     expect_value_read('1').in_sequence(falling)
#     expect_value_read('0').at_least_once.in_sequence(falling)
#     pin.interrupt(:falling) do
#       interrupted = true
#       pin.clear_interrupt
#     end
#     timeout { interrupted }
#     assert interrupted
#   end

#   def test_interrupt_both
#     pin = PiDriver::Pin.new @pin_number

#     interrupted = false
#     both = sequence('both')
#     expect_value_read('0').in_sequence(both)
#     expect_value_read('1').at_least_once.in_sequence(both)
#     pin.interrupt(:both) do
#       interrupted = true
#       pin.clear_interrupt
#     end
#     timeout { interrupted }
#     assert interrupted

#     interrupted = false
#     both = sequence('both')
#     expect_value_read('1').in_sequence(both)
#     expect_value_read('0').at_least_once.in_sequence(both)
#     pin.interrupt(:both) do
#       interrupted = true
#       pin.clear_interrupt
#     end
#     timeout { interrupted }
#     assert interrupted
#   end

#   def test_interrupt_none
#     pin = PiDriver::Pin.new @pin_number

#     interrupted = false
#     none = sequence('none')
#     expect_value_read('0').in_sequence(none)
#     expect_value_read('1').at_least_once.in_sequence(none)
#     pin.interrupt(:none) { interrupted = true }
#     timeout { interrupted }
#     refute interrupted
#     pin.clear_interrupt

#     interrupted = false
#     none = sequence('none')
#     expect_value_read('1').in_sequence(none)
#     expect_value_read('0').at_least_once.in_sequence(none)
#     pin.interrupt(:none) { interrupted = true }
#     timeout { interrupted }
#     refute interrupted
#     pin.clear_interrupt
#   end
# end
