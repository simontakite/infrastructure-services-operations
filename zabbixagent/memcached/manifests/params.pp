# == Class memcached::params
#
# This class is meant to be called from memcached.
# It sets variables according to platform.
#
class memcached::params {
  case $::osfamily {
    'Debian': {
      $package_name = ['memcached','php5-memcached', 'php5-memcache']
      $service_name = 'memcached'
    }
    'RedHat', 'Amazon': {
      $package_name = ['memcached','php5-memcached', 'php5-memcache']
      $service_name = 'memcached'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
