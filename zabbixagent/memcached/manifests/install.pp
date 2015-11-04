# == Class memcached::install
#
# This class is called from memcached for install.
#
class memcached::install {

  package { $::memcached::package_name:
    ensure => present,
  }
}
