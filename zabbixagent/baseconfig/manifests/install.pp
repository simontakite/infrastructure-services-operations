# == Class baseconfig::install
#
# This class is called from baseconfig for install.
#
class baseconfig::install {

  package { $::baseconfig::package_name:
    ensure => present,
  }
}
