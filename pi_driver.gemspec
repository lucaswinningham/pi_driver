Gem::Specification.new do |s|
  s.name        = 'pi_driver'
  s.version     = '0.0.1'
  s.date        = '2018-03-15'
  s.summary     = "Ruby driver for Raspberry Pi"
  s.description = "Ruby driver for Raspberry Pi"
  s.authors     = ["Lucas Winningham"]
  s.email       = 'lucas.winningham@gmail.com'
  s.executables = ['pin.rb']
  s.files       = ["lib/pi_driver.rb", "lib/pi_driver/pin.rb", "lib/pi_driver/i2c_master.rb"]
  s.homepage    = 'http://rubygems.org/gems/pi_driver'
  s.license     = 'MIT'

  s.add_runtime_dependency 'mocha'
end