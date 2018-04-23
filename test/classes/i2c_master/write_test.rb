require_relative '../i2c_master_test_helper'

class I2CWriteTest < I2CMasterTest
  def test_write
    @sequence = sequence('write')
    expect_bit_write 1
    expect_bit_write 0
    expect_bit_write 1
    expect_bit_write 1
    expect_bit_write 0
    expect_bit_write 0
    expect_bit_write 0
    expect_bit_write 1

    @i2c_master.write 0b10110001
  end

  private

  def expect_bit_write(value)
    value.zero? ? expect_data_pin_to_be_driven : expect_data_pin_to_be_released
    expect_clock_pin_to_be_released
    expect_data_pin_is_clear_to_return false
    expect_clock_pin_to_be_driven
  end
end
