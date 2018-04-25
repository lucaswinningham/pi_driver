require_relative '../pin_test_helper'

class IntegrationPinClearTest < IntegrationPinTest
  def test_clear
    @active_low_writer.output 0

    timeout { @active_low_reader.clear? && @active_high_reader.clear? }
    assert @active_low_reader.clear? && @active_high_reader.clear?
  end
end
