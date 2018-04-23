require_relative '../i2c_master_test_helper'

class IntegrationI2CWriteTest < IntegrationI2CMasterTest
  def setup
    super
    @i2c_master.start
  end

  def test_write
    byte = 0b10110001
    bits = [1, 0, 1, 1, 0, 0, 0, 1]
    bit_index = 0

    @slave_scl.interrupt(:rising) do
      assert_equal bits[bit_index], @slave_sda.value
      bit_index += 1
    end

    @i2c_master.write byte
    assert bit_index >= bits.length

    @slave_scl.clear_interrupt
  end
end
