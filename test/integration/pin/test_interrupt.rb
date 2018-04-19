require_relative '../pin_test_helper'

class IntegrationPinInterruptTest < IntegrationPinTest
  def test_interrupt
    interrupted = false
    @getter.interrupt { interrupted = true }
    @setter.set
    timeout { interrupted }
    assert interrupted
    @getter.clear_interrupt
  end
end
