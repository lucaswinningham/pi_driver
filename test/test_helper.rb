if ENV['COV']
  require 'simplecov'
  SimpleCov.start
end

require 'minitest/autorun'
require 'pi_driver'
require 'mocha/minitest'

if ENV['VERBOSE']
  require 'minitest/reporters'
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
end

class TestCase < Minitest::Test
  def setup; end

  def timeout(seconds = 0.5)
    started_at = Time.now
    until (success = yield)
      break if Time.now - started_at > seconds
    end
    success
  end
end
