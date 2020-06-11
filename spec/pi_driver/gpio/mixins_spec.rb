# frozen_string_literal: true

require 'pi_driver/gpio/mixins'
require 'support/matchers/mixin'

RSpec.describe PiDriver::GPIO::Mixins do
  it { expect(subject).to mix_in('Export', 'Direction', 'Value') }

  describe '#gpio_number' do
    let(:instance) { Class.new { include PiDriver::GPIO::Mixins }.new }

    it { expect { instance.gpio_number }.to raise_error NotImplementedError }
  end
end
