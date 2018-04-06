require_relative '../mcp23017_test_helper'

class MCP23017ErrorTest < MCP23017Test
  def test_error_hardware_address
    assert_raises ArgumentError do
      @mcp23017.hardware_address.a0 = 2
    end
  end

  def test_error_register_bit
    register = PiDriver::Device::MCP23017::Register.new

    assert_raises ArgumentError do
      register.bit0 = 2
    end
  end

  def test_error_register_port
    register = PiDriver::Device::MCP23017::Register.new

    assert_raises ArgumentError do
      register.port = 256
    end

    assert_raises ArgumentError do
      register.port = -1
    end
  end
end
