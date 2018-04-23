require_relative '../i2c_master_test_helper'

class I2CStartTest < I2CMasterTest
  def test_start
    @sequence = sequence('start')
    expect_data_pin_to_be_released
    expect_clock_pin_to_be_released
    expect_data_pin_to_be_driven
    expect_clock_pin_to_be_driven

    @i2c_master.start
  end
end
