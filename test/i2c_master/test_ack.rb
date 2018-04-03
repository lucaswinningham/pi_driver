require_relative '../i2c_master_test_helper'

class I2CAckTest < I2CMasterTest
  def test_ack
    @sequence = sequence('ack')
    expect_sequence_ack true

    assert @i2c_master.ack
  end

  def test_nack
    @sequence = sequence('nack')
    expect_sequence_ack false

    refute @i2c_master.ack
  end
end
