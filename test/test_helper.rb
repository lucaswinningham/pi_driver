require 'minitest/autorun'
require 'pi_driver'
require 'mocha/minitest'

class TestCase < Minitest::Test
  def timeout(seconds = 0.5)
    success = false
    started_at = Time.now
    while !(success = yield) do
      break if Time.now - started_at > seconds
    end
    success
  end
end