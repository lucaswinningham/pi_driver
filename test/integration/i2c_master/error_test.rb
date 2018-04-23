require_relative '../i2c_master_test_helper'

class IntegrationI2CErrorTest < IntegrationI2CMasterTest
  def setup
    super
    @slave_sda.output
  end

  def test_error_arbitration_start
    assert_raises PiDriver::I2CMaster::ArbitrationError do
      @i2c_master.start
    end
  end

  def test_error_arbitration_stop
    assert_raises PiDriver::I2CMaster::ArbitrationError do
      @i2c_master.stop
    end
  end

  def test_error_arbitration_write_bit
    assert_raises PiDriver::I2CMaster::ArbitrationError do
      @i2c_master.write 0b11111111
    end
  end
end
