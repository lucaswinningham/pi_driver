#!
# ruby -Ilib ./bin/pin.rb 10

require 'pi_driver'
puts PiDriver::Pin.new(ARGV[0]).clear?
