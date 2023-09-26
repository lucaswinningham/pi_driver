# frozen_string_literal: true

require 'pi_driver/gpio/options'

require 'pi_driver/pinout'
# require 'pi_driver/gpio/options/mixins'

RSpec.describe PiDriver::GPIO::Options do
  describe '#initialize' do
    context 'when neither :gpio_number nor :pin_number are provided' do
      it do
        expect { described_class.new }.to(
          raise_error PiDriver::GPIO::Options::InvalidOptions
        )
      end
    end

    context 'when :gpio_number provided' do
      context 'and is valid' do
        let(:options) { { gpio_number: rand(100) } }

        before do
          gpio_numbers_double = double 'gpio_numbers'
          allow(PiDriver::Pinout).to receive(:gpio_numbers) { gpio_numbers_double }
          allow(gpio_numbers_double).to receive(:include?) { true }

          gpio_numbers_to_pin_numbers_double = double 'gpio_numbers_to_pin_numbers'
          allow(PiDriver::Pinout).to receive(:gpio_numbers_to_pin_numbers) do
            gpio_numbers_to_pin_numbers_double
          end
          allow(gpio_numbers_to_pin_numbers_double).to receive(:[])
        end

        it 'does not raise error' do
          expect { described_class.new(**options) }.not_to raise_error
        end
      end

      context 'and is not valid' do
        let(:options) { { gpio_number: rand(100) } }

        before do
          gpio_numbers_double = double 'gpio_numbers'
          allow(PiDriver::Pinout).to receive(:gpio_numbers) { gpio_numbers_double }
          allow(gpio_numbers_double).to receive(:include?) { false }
        end

        it do
          expect { described_class.new(**options) }.to(
            raise_error PiDriver::GPIO::Options::InvalidOptions
          )
        end
      end
    end
  end
end
