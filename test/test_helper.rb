if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'byebug'
require 'minitest/autorun'
require 'pi_driver'
require 'mocha/minitest'
require "awesome_print"

class TestCase < Minitest::Test
  def timeout(seconds = 0.5)
    started_at = Time.now
    until (success = yield)
      break if Time.now - started_at > seconds
    end
    success
  end
end
