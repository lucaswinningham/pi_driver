require_relative '../i2c_master_test_helper'

class IntegrationI2CAckTest < IntegrationI2CMasterTest
  def setup
    super
    @i2c_master.start
  end

  def test_ack
    @slave_sda.output
    assert @i2c_master.ack
  end

  def test_nack
    refute @i2c_master.ack
  end
end
