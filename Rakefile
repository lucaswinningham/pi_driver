require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  test_directory = 'classes'
  t.pattern = 'test/classes/**/test_*.rb'

  specific_tests = ARGV.last
  if specific_tests
    task(specific_tests.to_sym {})
    test_directory = (specific_tests == 'all' ? '**' : specific_tests)
  end

  t.pattern = "test/#{test_directory}/**/test_*.rb"
end

desc 'Run tests'
task default: :test
