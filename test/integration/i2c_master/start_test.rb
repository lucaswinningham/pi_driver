require_relative '../i2c_master_test_helper'

class IntegrationI2CStartTest < IntegrationI2CMasterTest
  def test_start
    data_pin_driven = false
    clock_pin_driven = false
    data_pin_driven_first = false

    @slave_sda.interrupt(:falling) do
      data_pin_driven = true
      data_pin_driven_first = !clock_pin_driven
    end

    @slave_scl.interrupt(:falling) { clock_pin_driven = true }

    @i2c_master.start
    assert data_pin_driven && clock_pin_driven && data_pin_driven_first

    @slave_sda.clear_interrupt
    @slave_scl.clear_interrupt
  end
end
