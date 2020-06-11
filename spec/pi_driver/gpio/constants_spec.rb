# frozen_string_literal: true

require 'pi_driver/gpio/constants'

RSpec.describe PiDriver::GPIO::Constants do
  describe '::HIGH' do
    it { expect(subject::HIGH).to eq 1 }
  end

  describe '::LOW' do
    it { expect(subject::LOW).to eq 0 }
  end

  describe '::IN' do
    it { expect(subject::IN).to eq 'in' }
  end

  describe '::OUT' do
    it { expect(subject::OUT).to eq 'out' }
  end
end
