require_relative '../pin_test_helper'

class PinInitializeTest < PinTest
  def test_direction_valid_values
    %i[in out high low].each do |direction|
      expect_direction_write direction
      PiDriver::Pin.new @gpio_number, direction: direction
    end
  end

  def test_no_direction
    expect_direction_write(nil).never
    PiDriver::Pin.new @gpio_number
  end

  def test_ignore_state_for_input
    expect_direction_read 'in'
    expect_value_write(1).never
    PiDriver::Pin.new @gpio_number, state: 1
  end

  def test_observe_state_for_output
    expect_direction_read 'out'
    expect_value_write 1
    PiDriver::Pin.new @gpio_number, state: 1
  end

  def test_observe_state_for_high
    expect_direction_write :high
    expect_direction_read 'out'
    expect_value_write 0
    PiDriver::Pin.new @gpio_number, direction: :high, state: 0
  end

  def test_observe_state_for_low
    expect_direction_write :low
    expect_direction_read 'out'
    expect_value_write 1
    PiDriver::Pin.new @gpio_number, direction: :low, state: 1
  end
end
