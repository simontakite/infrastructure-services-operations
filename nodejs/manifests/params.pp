# == Class nodejs::params
#
# This class is meant to be called from nodejs.
# It sets variables according to platform.
#
class nodejs::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'nodejs'
      $service_name = 'nodejs'
    }
    'RedHat', 'Amazon': {
      $package_name = 'nodejs'
      $service_name = 'nodejs'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
