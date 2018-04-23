require_relative '../integration_test_helper'

class IntegrationI2CMasterTest < IntegrationTest
  def setup
    @master_scl = PiDriver::Pin.new 5
    @slave_scl = PiDriver::Pin.new 6
    @master_sda = PiDriver::Pin.new 19
    @slave_sda = PiDriver::Pin.new 26

    @i2c_master = PiDriver::I2CMaster.new clock_pin: @master_scl, data_pin: @master_sda
  end
end
