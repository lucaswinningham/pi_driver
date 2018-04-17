Gem::Specification.new do |s|
  s.name        = 'pi_driver'
  s.version     = '0.0.3'
  s.date        = '2018-04-17'
  s.summary     = "Ruby driver for Raspberry Pi"
  s.description = "Ruby driver for Raspberry Pi with device drivers"
  s.authors     = ["Lucas Winningham"]
  s.email       = 'lucas.winningham@gmail.com'
  s.executables = ['pin.rb']
  s.files       = Dir["{bin,lib,test}/**/*"].keep_if { |file| File.file?(file) }
  s.homepage    = 'http://rubygems.org/gems/pi_driver'
  s.license     = 'MIT'

  s.add_runtime_dependency 'mocha', '~> 1.4', '>= 1.4.0'
end