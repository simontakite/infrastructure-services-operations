# == Class php::install
#
# This class is called from php for install.
#
class php::install {

  package { $::php::package_name:
    ensure => present,
  }
}
