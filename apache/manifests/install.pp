# == Class apache::install
#
# This class is called from apache for install.
#
class apache::install {

  package { $::apache::package_name:
    ensure => present,
  }
}
