require_relative '../pin_test_helper'

class IntegrationPinSetTest < IntegrationPinTest
  def test_set
    @setter.input
    assert @getter.set?
  end
end
