require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/classes/**/test_*.rb'

  specific_tests = ARGV.last
  if specific_tests
    task(specific_tests.to_sym {})
    t.pattern = "test/#{specific_tests}/**/test_*.rb"
  end
end

desc 'Run tests'
task default: :test
