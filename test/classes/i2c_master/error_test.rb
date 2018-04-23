require_relative '../i2c_master_test_helper'

class I2CErrorTest < I2CMasterTest
  def test_error_arbitration_start
    assert_raises PiDriver::I2CMaster::ArbitrationError do
      @sequence = sequence('error start')
      expect_data_pin_to_be_released
      expect_clock_pin_to_be_released
      expect_data_pin_is_clear_to_return true

      @i2c_master.start
    end
  end

  def test_error_arbitration_stop
    assert_raises PiDriver::I2CMaster::ArbitrationError do
      @sequence = sequence('error stop')
      expect_data_pin_to_be_driven
      expect_clock_pin_to_be_released
      expect_data_pin_to_be_released
      expect_data_pin_is_clear_to_return true

      @i2c_master.stop
    end
  end

  def test_error_arbitration_write_bit
    assert_raises PiDriver::I2CMaster::ArbitrationError do
      @sequence = sequence('error write bit')
      expect_data_pin_to_be_released
      expect_clock_pin_to_be_released
      expect_data_pin_is_clear_to_return true

      @i2c_master.write 0b11111111
    end
  end
end
