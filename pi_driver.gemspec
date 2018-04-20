Gem::Specification.new do |s|
  s.name        = 'pi_driver'
  s.version     = '0.0.4'
  s.date        = '2018-04-18'
  s.summary     = 'Ruby driver for Raspberry Pi'
  s.description = 'Ruby driver for Raspberry Pi with device drivers'
  s.authors     = ['Lucas Winningham']
  s.email       = 'lucas.winningham@gmail.com'
  s.executables = ['pin.rb']
  s.files       = Dir['{bin,lib,test}/**/*'].keep_if { |file| File.file?(file) }
  s.homepage    = 'http://rubygems.org/gems/pi_driver'
  s.license     = 'MIT'

  # TODO: figure out difference between runtime and development dependencies
  s.add_runtime_dependency 'byebug',    '~> 10.0.0', '>= 10.0.0'
  s.add_runtime_dependency 'minitest',  '~> 5.11.3', '>= 5.11.3'
  s.add_runtime_dependency 'mocha',     '~> 1.4',    '>= 1.4.0'
  s.add_runtime_dependency 'rubocop',   '~> 0.51.0', '>= 0.51.0'
  s.add_runtime_dependency 'simplecov', '~> 0.15.1', '>= 0.15.1'
end
