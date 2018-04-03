require_relative '../i2c_master_test_helper'

class I2CStopTest < I2CMasterTest
  def test_stop
    @sequence = sequence('stop')
    expect_sequence_stop

    @i2c_master.stop
  end
end
