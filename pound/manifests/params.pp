# == Class pound::params
#
# This class is meant to be called from pound.
# It sets variables according to platform.
#
class pound::params {
  $default_file		= '/etc/default/pound'
  $config_file		= '/etc/pound/pound.cfg'
  $config_file_temp = 'pound/pound.cfg.erb'
  $user             = 'www-data'
  $group            = 'www-data'
  $alive            = '30'
  $listen_address   = '0.0.0.0'
  $listen_port      = '80'
  case $::osfamily {
    'Debian': {
      $package_name 	= 'pound'
      $service_name 	= 'pound'
    }
    'RedHat', 'Amazon': {
      $package_name 	= 'pound'
      $service_name 	= 'pound'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
