require_relative '../i2c_master_test_helper'

class I2CReadTest < I2CMasterTest
  def test_read
    @sequence = sequence('read')
    expect_data_pin_to_be_released
    expect_bit_read 1
    expect_bit_read 0
    expect_bit_read 0
    expect_bit_read 0
    expect_bit_read 1
    expect_bit_read 1
    expect_bit_read 0
    expect_bit_read 1

    byte = @i2c_master.read
    assert_equal 0b10001101, byte
  end
end
