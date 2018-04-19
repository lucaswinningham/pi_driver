require_relative '../pin_test_helper'

class IntegrationPinClearTest < IntegrationPinTest
  def test_clear
    assert @getter.clear?
  end
end
