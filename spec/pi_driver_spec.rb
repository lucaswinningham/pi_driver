# frozen_string_literal: true

require 'pi_driver'

require 'pi_driver/configuration'

RSpec.describe PiDriver do
  describe '::configure' do
    it 'passes configuration to block' do
      configuration_double = double 'configuration'
      expect(PiDriver::Configuration).to receive(:new).with(no_args) { configuration_double }

      subject.configure do |config|
        expect(config).to be configuration_double
      end
    end
  end
end
