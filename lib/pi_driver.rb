require_relative 'pi_driver/device'
require_relative 'pi_driver/i2c_master'
require_relative 'pi_driver/pin'
require_relative 'pi_driver/utils'

ENV['OS'] = if /darwin/ =~ RUBY_PLATFORM
              'mac'
            else
              'pi'
            end

module PiDriver
end
