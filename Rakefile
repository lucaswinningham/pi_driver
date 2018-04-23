require 'rake/testtask'

Rake::TestTask.new do |t|
  ENV['PI_ENV'] ||= 'test'
  t.libs << 'test'
  test_directory = 'classes'

  specific_tests = ARGV[1]
  if specific_tests
    task(specific_tests.to_sym {})
    test_directory = (specific_tests == 'all' ? '**' : specific_tests)
  end

  t.pattern = "test/#{test_directory}/**/*_test.rb"
end
