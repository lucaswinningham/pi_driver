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

  private

  def expect_sequence_ack(success)
    expect_data_pin_to_be_released
    expect_clock_pin_to_be_released
    @data_pin.expects(:clear?).with(nil).returns(success).in_sequence(@sequence)
    expect_clock_pin_to_be_driven
  end
end
