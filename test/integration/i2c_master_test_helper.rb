require_relative '../integration_test_helper'

class IntegrationI2CMasterTest < IntegrationTest
  def setup
    super
    @master_scl = PiDriver::Pin.new 12
    @slave_scl = PiDriver::Pin.new 16
    @master_sda = PiDriver::Pin.new 20
    @slave_sda = PiDriver::Pin.new 21

    @i2c_master = PiDriver::I2CMaster.new clock_pin: @master_scl, data_pin: @master_sda
  end
end
