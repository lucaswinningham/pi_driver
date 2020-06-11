# frozen_string_literal: true

require 'pi_driver'

RSpec.describe 'PiDriver::VERSION' do
  subject { PiDriver::VERSION }

  it 'is a version number' do
    expect(subject).to eq '0.1.0'
  end
end
