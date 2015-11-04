# == Class zabbixagent::install
#
# This class is called from zabbixagent for install.
#
class zabbixagent::install {

  package { $::zabbixagent::package_name:
    ensure => present,
  }
}
