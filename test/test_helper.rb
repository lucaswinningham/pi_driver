if ENV['COV']
  require 'simplecov'
  SimpleCov.start
end

require 'minitest/autorun'
require 'pi_driver'
require 'mocha/minitest'

class TestCase < Minitest::Test
  def timeout(seconds = 0.5)
    started_at = Time.now
    until (success = yield)
      break if Time.now - started_at > seconds
    end
    success
  end
end
