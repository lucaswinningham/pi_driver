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

    @i2c_master.write(0b10110001)
  end
end
