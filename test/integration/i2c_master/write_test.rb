require_relative '../i2c_master_test_helper'

class IntegrationI2CWriteTest < IntegrationI2CMasterTest
  def test_write
    @i2c_master.start

    byte = 0b10110001
    bits = [1, 0, 1, 1, 0, 0, 0, 1]
    bit_index = 0

    @slave_scl.interrupt(:rising) do
      assert (bits[bit_index] == 1 ? @slave_sda.set? : @slave_sda.clear?)
      bit_index += 1
    end

    @i2c_master.write byte
    assert bit_index >= bits.length

    @slave_scl.clear_interrupt
  end
end
