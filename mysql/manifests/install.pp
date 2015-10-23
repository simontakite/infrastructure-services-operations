# == Class mysql::install
#
# This class is called from mysql for install.
#
class mysql::install {

  package { $::mysql::package_name:
    ensure => present,
  }
}
