# frozen_string_literal: true

require 'securerandom'

require 'pi_driver/gpio/mixins/export'

require 'support/mocks/mock_file_system'

require 'pi_driver/gpio/options'
require 'pi_driver/file_system'

RSpec.describe PiDriver::GPIO::Mixins::Export do
  let(:klass) { Class.new { include PiDriver::GPIO::Mixins::Export } }

  let(:random_gpio_number) { rand 100 } 

  before { mock_file_system }

  describe 'class methods' do
    let(:random_options) { { SecureRandom.hex => SecureRandom.hex } }
    let(:options_instance_double) do
      double('options_instance').tap do |dub|
        expect(dub).to receive(:gpio_number) { random_gpio_number }
      end
    end

    let(:expect_new_options_instance) do
      expect(PiDriver::GPIO::Options).to(
        receive(:new).with(random_options)
      ) { options_instance_double }
    end

    describe '::exported?' do
      it 'generates an instance Options'
      it 'calls Dir::exist? on gpio number dir'
    end

    describe '::unexported?' do
      it 'generates an instance Options'
      it 'calls Dir::exist? on gpio number dir'
    end

    describe '::export' do
      it 'generates an instance Options' do
        expect_new_options_instance

        klass.export(**random_options)
      end

      it 'calls FileSystem::write_file with export file and gpio number' do
        expect_new_options_instance

        expect(PiDriver::FileSystem).to(
          receive(:write_file).with(
            "#{PiDriver::FileSystem.dir.gpio}/export",
            contents: random_gpio_number
          )
        )

        klass.export(**random_options)
      end
    end

    describe '::unexport' do
      it 'generates an instance Options'
      it 'calls FileSystem::write_file with unexport file and gpio number'
    end
  end

  describe 'instance methods' do
    let(:instance) do
      klass.new.tap do |inst|
        allow(inst).to receive(:gpio_number) { random_gpio_number }
      end
    end

    describe '#exported?' do
      it 'calls ::exported? with gpio number'
    end

    describe '#unexported?' do
      it 'calls ::unexported? with gpio number'
    end

    describe '#export' do
      it 'calls ::export with gpio number' do
        expect(PiDriver::GPIO).to receive(:export).with(gpio_number: random_gpio_number)

        instance.export
      end
    end

    describe '#unexport' do
      it 'calls ::unexport with gpio number'
    end
  end
end
