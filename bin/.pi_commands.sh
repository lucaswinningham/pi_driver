#!/bin/bash

function pi() {
  if [ "$1" == install ]; then
    echo -e "not implemented yet... coming soon."
    # cd

    # sudo apt-get update
    # sudo apt-get upgrade

    # command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    # curl -L https://get.rvm.io | bash -s stable --ruby
    # source ~/.rvm/scripts/rvm
    # rvm install 2.4.1

    # sudo gem install bundler --no-rdoc --no-ri
    # touch .gemrc
    # echo -e "\ngem: --no-rdoc --no-ri\n" >> .gemrc

    # git clone https://github.com/lucaswinningham/pi_driver.git
    # cd pi_driver/

    # bundle

    # echo -e "\n\n\tSuccessfully installed Pi Driver.\n\n"
  elif [ "$1" == console ]; then
    irb -r ./lib/pi_driver
  elif [ "$1" == test ]; then
    rake test "${@:2}"
  fi
}
