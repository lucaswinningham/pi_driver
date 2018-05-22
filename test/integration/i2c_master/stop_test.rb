require_relative '../i2c_master_test_helper'

class IntegrationI2CStopTest < IntegrationI2CMasterTest
  def test_stop
    @master_scl.output 0
    @master_sda.output 0

    timeout_all_clear
    assert_all_clear

    clock_pin_released = false
    data_pin_released = false
    clock_pin_released_first = false

    @slave_scl.interrupt(:rising) do
      clock_pin_released = true
      clock_pin_released_first = !data_pin_released
    end

    @slave_sda.interrupt(:rising) { data_pin_released = true }

    @i2c_master.stop

    timeout { clock_pin_released && data_pin_released && clock_pin_released_first }
    assert clock_pin_released && data_pin_released && clock_pin_released_first

    @slave_scl.clear_interrupt
    @slave_sda.clear_interrupt
  end

  private

  def timeout_all_clear
    timeout { @master_scl.clear? && @slave_scl.clear? && @master_sda.clear? && @slave_sda.clear? }
  end

  def assert_all_clear
    assert @master_scl.clear? && @slave_scl.clear? && @master_sda.clear? && @slave_sda.clear?
  end
end
