# == Class php::params
#
# This class is meant to be called from php.
# It sets variables according to platform.
#
class php::params {
  case $::osfamily {
    'Debian': {
      $package_name = ['php5', 'libapache2-mod-php5', 'php5-mcrypt']
    }
    'RedHat', 'Amazon': {
      $package_name = ['php5', 'libapache2-mod-php5', 'php5-mcrypt']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
