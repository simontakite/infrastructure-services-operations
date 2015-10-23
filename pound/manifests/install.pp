# == Class pound::install
#
# This class is called from pound for install.
#
class pound::install {

  package { $::pound::package_name:
    ensure => present,
    before => File[$::pound::config_file],
  }
}
