# frozen_string_literal: true

RSpec.describe 'rubocop' do
  subject(:report) { `rubocop` }

  it 'has no offenses' do
    expect(report).to match(/no offenses detected/)
  end
end
