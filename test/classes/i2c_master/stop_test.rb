require_relative '../i2c_master_test_helper'

class I2CStopTest < I2CMasterTest
  def test_stop
    @sequence = sequence('stop')
    expect_data_pin_to_be_driven
    expect_clock_pin_to_be_released
    expect_data_pin_to_be_released
    expect_data_pin_is_clear_to_return false

    @i2c_master.stop
  end
end
