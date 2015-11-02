# == Class logstashforwarder::params
#
# This class is meant to be called from logstashforwarder.
# It sets variables according to platform.
#
class logstashforwarder::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'logstash-forwarder'
      $service_name = 'logstash-forwarder'
    }
    'RedHat', 'Amazon': {
      $package_name = 'logstash-forwarder'
      $service_name = 'logstash-forwarder'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
