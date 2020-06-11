# frozen_string_literal: true

require 'pi_driver/configuration'

require 'pi_driver/cpu_info'

RSpec.describe PiDriver::Configuration do
  subject { described_class.new }

  describe '#hardware=' do
    it 'sets hardware on CPUInfo' do
      hardware = 'foo'
      expect(PiDriver::CPUInfo).to receive(:hardware=).with(hardware)

      subject.hardware = hardware
    end
  end
end
