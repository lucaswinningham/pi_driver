require_relative '../i2c_master_test_helper'

class IntegrationI2CReadTest < IntegrationI2CMasterTest
  def test_read
    @i2c_master.start

    @bits = [1, 0, 0, 0, 1, 1, 0, 1]
    @bit_index = 0
    set_slave_data_pin

    @slave_scl.interrupt(:falling) do
      @bit_index += 1
      @bit_index < @bits.length ? set_slave_data_pin : @slave_scl.clear_interrupt
    end

    byte = @i2c_master.read

    assert_equal 0b10001101, byte
  end

  private

  def set_slave_data_pin
    @bits[@bit_index].zero? ? @slave_sda.output : @slave_sda.input
  end
end
