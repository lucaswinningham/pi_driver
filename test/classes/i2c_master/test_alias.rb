require_relative '../i2c_master_test_helper'

class I2CAliasTest < I2CMasterTest
  def test_start_aliases
    assert_equal @i2c_master.method(:start), @i2c_master.method(:restart)
  end
end
