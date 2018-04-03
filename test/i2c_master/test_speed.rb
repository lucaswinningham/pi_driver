require_relative '../i2c_master_test_helper'

class I2CSpeedTest < I2CMasterTest
  def test_speed
    @sequence = sequence('speed')
    expect_clock_pin_to_be_released
    
    test_began_at = Time.now
    @i2c_master.send(:release_clock_pin)
    test_ended_at = Time.now
    frequency = (1.0 / (test_ended_at - test_began_at))
    assert frequency < 100_000
  end
end
