# == Class nodejs::install
#
# This class is called from nodejs for install.
#
class nodejs::install {

  package { $::nodejs::package_name:
    ensure => present,
  }
}
