# frozen_string_literal: true

RSpec.describe PiDriver do
  it 'has a version number' do
    expect(PiDriver::VERSION).not_to be nil
  end
end
