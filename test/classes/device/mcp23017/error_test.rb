require_relative '../mcp23017_test_helper'

class MCP23017ErrorTest < MCP23017Test
  def test_error_new_i2c_master
    assert_raises ArgumentError do
      @i2c_master = Object.new
      @mcp23017 = PiDriver::Device::MCP23017.new i2c_master: @i2c_master
    end
  end

  def test_error_hardware_address
    assert_raises ArgumentError do
      @mcp23017.hardware_address.a0 = 2
    end
  end

  def test_error_register_bit
    assert_raises ArgumentError do
      @mcp23017.iodira.bit0 = 2
    end
  end

  def test_error_register_port
    assert_raises ArgumentError do
      @mcp23017.iodira.byte = 256
    end

    assert_raises ArgumentError do
      @mcp23017.iodira.byte = -1
    end
  end

  def test_error_write
    assert_raises ArgumentError do
      @mcp23017.write :invalid_register
    end
  end

  def test_error_read
    assert_raises ArgumentError do
      @mcp23017.read :invalid_register
    end
  end
end
