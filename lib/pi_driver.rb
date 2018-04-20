require_relative 'pi_driver/device'
require_relative 'pi_driver/i2c_master'
require_relative 'pi_driver/pin'
require_relative 'pi_driver/utils'

if (/darwin/ =~ RUBY_PLATFORM) != nil
  ENV['OPERATING_SYSTEM'] = 'mac'
else
  ENV['OPERATING_SYSTEM'] = 'pi'
end

module PiDriver
end
