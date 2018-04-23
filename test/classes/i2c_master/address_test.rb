require_relative '../i2c_master_test_helper'

class I2CAddressTest < I2CMasterTest
  def test_class_prepare_address_for_write
    address_byte = 0b1010101
    prepared_address = PiDriver::I2CMaster.prepare_address_for_write address_byte
    assert_equal 0b10101010, prepared_address
  end

  def test_class_prepare_address_for_read
    address_byte = 0b1010101
    prepared_address = PiDriver::I2CMaster.prepare_address_for_read address_byte
    assert_equal 0b10101011, prepared_address
  end
end
