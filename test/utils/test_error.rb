require_relative '../utils_test_helper'

class UtilsErrorTest < UtilsTest
  def test_error_interrupt_new_block
    assert_raises ArgumentError do
      PiDriver::Utils::Interrupt.new(:rising)
    end
  end

  def test_error_interrupt_start_block
    assert_raises ArgumentError do
      interrupt = PiDriver::Utils::Interrupt.new(:rising) { [0, 1].sample }
      interrupt.start
    end
  end

  def test_error_interrupt_yield_state
    assert_raises ArgumentError do
      begin
        interrupt = PiDriver::Utils::Interrupt.new(:rising) { 2 }
        interrupted = false
        thread = interrupt.start { interrupted = true }
        timeout { interrupted }
      ensure
        thread.kill
      end
    end
  end
end
