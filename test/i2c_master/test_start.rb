require_relative '../i2c_master_test_helper'

class I2CStartTest < I2CMasterTest
  def test_start
    @sequence = sequence('start')
    expect_sequence_start

    @i2c_master.start
  end
end
