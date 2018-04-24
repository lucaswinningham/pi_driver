require 'rake/testtask'

Rake::TestTask.new do |t|
  ENV['PI_ENV'] ||= 'test'
  t.libs << 'test'

  directory = ARGV[1]
  test_file = ARGV[2]

  if directory
    task(directory.to_sym {})
    directory = '**' if directory == 'all'

    test_file = ARGV[2]
    task(test_file.to_sym {}) if test_file
  end

  directory ||= 'classes'
  test_file ||= '*'

  t.pattern = "test/#{directory}/**/#{test_file}_test.rb"
end
