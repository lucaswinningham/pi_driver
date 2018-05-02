require_relative '../i2c_master_test_helper'

class I2CInitializeTest < I2CMasterTest
  def test_new_pins_release
    @sequence = sequence('stop')
    expect_data_pin_to_be_released
    expect_clock_pin_to_be_released

    PiDriver::I2CMaster.new clock_pin: @clock_pin, data_pin: @data_pin
  end
end
