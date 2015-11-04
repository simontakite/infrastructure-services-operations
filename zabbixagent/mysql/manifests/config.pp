# == Class mysql::config
#
# This class is called from mysql for service config.
#
class mysql::config {
  file { $::mysql::mycnf:
    ensure  => 'file',
    source  => 'puppet:///modules/mysql/my.cnf',
    group   => '0',
    mode    => '0644',
    owner   => '0',
    require => Package['mysql-server'],
  }
}
