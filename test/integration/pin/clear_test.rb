require_relative '../pin_test_helper'

class IntegrationPinClearTest < IntegrationPinTest
  def test_clear
    @active_low_writer.output 0
    assert @active_low_reader.clear?

    assert @active_high_reader.clear?
  end
end
