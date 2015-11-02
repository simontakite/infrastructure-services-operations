# == Class logstashforwarder::install
#
# This class is called from logstashforwarder for install.
#
class logstashforwarder::install {

  package { $::logstashforwarder::package_name:
    ensure => present,
  }
}
