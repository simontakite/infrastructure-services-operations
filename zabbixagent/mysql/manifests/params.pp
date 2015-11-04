# == Class mysql::params
#
# This class is meant to be called from mysql.
# It sets variables according to platform.
#
class mysql::params {
  $mycnf         = '/etc/mysql/my.cnf'

  case $::osfamily {
    'Debian': {
      # Install mysql with some bindings
      $package_name = ['mysql-server', 'libapache2-mod-auth-mysql', 'php5-mysql']
      $service_name = 'mysql'
    }
    'RedHat', 'Amazon': {
      $package_name = ['mysql-server', 'libapache2-mod-auth-mysql', 'php5-mysql']
      $service_name = 'mysql'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
