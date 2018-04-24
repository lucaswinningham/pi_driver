require_relative '../pin_test_helper'

class IntegrationPinInterruptTest < IntegrationPinTest
  def test_interrupt
    active_low_interrupted = false
    active_high_interrupted = false

    @active_low_reader.interrupt(:falling) { active_low_interrupted = true }
    @active_high_reader.interrupt(:rising) { active_high_interrupted = true }

    @active_low_writer.output 0
    @active_high_writer.output 1

    timeout { active_low_interrupted && active_high_interrupted }
    assert active_low_interrupted && active_high_interrupted

    @active_low_reader.clear_interrupt
    @active_high_reader.clear_interrupt
  end
end
