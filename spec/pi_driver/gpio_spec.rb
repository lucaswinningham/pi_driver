# frozen_string_literal: true

require 'pi_driver/gpio'

require 'pi_driver/gpio/mixins'
require 'pi_driver/gpio/options'

RSpec.describe PiDriver::GPIO do
  it { expect(described_class.included_modules).to include PiDriver::GPIO::Mixins }

  subject { described_class.new }

  let(:options_double) { double 'options' }

  before { allow(PiDriver::GPIO::Options).to receive(:new) { options_double } }

  describe '#initialize' do
    it 'calls Options::new with given options' do
      options = { foo: 'foo', bar: 'bar', baz: 'baz' }
      expect(PiDriver::GPIO::Options).to receive(:new).with(**options) { options_double }

      described_class.new(**options)
    end
  end

  describe '#options' do
    it 'is the result of Options::new' do
      instance = described_class.new
      expect(instance.options).to be options_double
    end
  end

  describe '#gpio_number' do
    it 'gets gpio_number from #options' do
      gpio_number = rand 100
      expect(options_double).to receive(:gpio_number) { gpio_number }

      expect(subject.gpio_number).to be gpio_number
    end
  end

  describe '#pin_number' do
    it 'gets pin_number from #options' do
      pin_number = rand 100
      expect(options_double).to receive(:pin_number) { pin_number }

      expect(subject.pin_number).to be pin_number
    end
  end
end
