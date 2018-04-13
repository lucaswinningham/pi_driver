require_relative '../utils_test_helper'

class UtilsErrorTest < UtilsTest
  def test_error_interrupt_new_block
    assert_raises ArgumentError do
      PiDriver::Utils::Interrupt.new(:rising)
      timeout 0.1 { false }
    end
  end

  def test_error_interrupt_start_block
    assert_raises ArgumentError do
      interrupt = PiDriver::Utils::Interrupt.new(:rising) { [0, 1].sample }
      interrupt.start
      timeout 0.1 { false }
    end
  end

  def test_error_interrupt_yield_state
    assert_raises ArgumentError do
      interrupt = PiDriver::Utils::Interrupt.new(:rising) { 2 }
      interrupted = false
      interrupt.start { interrupted = true }
      timeout { interrupted }
    end
  end
end
