require 'rake/testtask'
require "awesome_print"

Rake::TestTask.new do |t|
  ENV['PI_ENV'] = 'TEST'
  t.libs << 'test'
  test_directory = 'classes'

  specific_tests = ARGV[1]
  if specific_tests
    task(specific_tests.to_sym {})
    test_directory = (specific_tests == 'all' ? '**' : specific_tests)
  end

  t.pattern = "test/#{test_directory}/**/test_*.rb"
end
