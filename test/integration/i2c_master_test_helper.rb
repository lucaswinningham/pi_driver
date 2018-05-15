require_relative '../integration_test_helper'

class IntegrationI2CMasterTest < IntegrationTest
  def setup
    super
    @master_scl = PiDriver::Pin.new 12, direction: :in
    @slave_scl = PiDriver::Pin.new 16, direction: :in
    @master_sda = PiDriver::Pin.new 20, direction: :in
    @slave_sda = PiDriver::Pin.new 21, direction: :in

    @i2c_master = PiDriver::I2CMaster.new clock_pin: @master_scl, data_pin: @master_sda

    assert(timeout { @master_scl.set? && @slave_scl.set? && @master_sda.set? && @slave_sda.set? })
  end
end
