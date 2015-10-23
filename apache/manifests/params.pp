# == Class apache::params
#
# This class is meant to be called from apache.
# It sets variables according to platform.
#
class apache::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'apache2'
      $service_name = 'apache2'
    }
    'RedHat', 'Amazon': {
      $package_name = 'apache2'
      $service_name = 'apache2'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
