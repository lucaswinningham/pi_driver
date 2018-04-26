#!/bin/bash

function pi() {
  working_directory=$(basename "$PWD")
  print_help=false
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
  elif [ "$working_directory" == "pi_driver" ]; then
    if [ "$1" == console ]; then
      irb -r ./lib/pi_driver
    elif [ "$1" == test ]; then
      rake test "${@:2}"
    elif [ "$1" == help ]; then
      print_help=true
    else
      print_help=true
    fi
  else
    print_help=true
  fi

  if [ "$print_help" == true ]; then
    read -r -d '' help_message << HELP
Usage:
  pi [options]

Options:
  install             # Automatically install and update software and packages
  console             # Open irb enviroment for use with Pi Driver
  help                # Show this help message and quit
  test [test_options] # Test the Pi Driver

Test Options:
  classes [directory] [test_prefix]     # Test the program suite
  integration [directory] [test_prefix] # Test real circuitry
HELP
    echo -e "$help_message"
  fi
}
