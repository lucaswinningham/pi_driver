require_relative '../pin_test_helper'

class IntegrationPinSetTest < IntegrationPinTest
  def test_set
    assert @active_low_reader.set?

    @active_high_writer.output 1
    assert @active_high_reader.set?
  end
end
