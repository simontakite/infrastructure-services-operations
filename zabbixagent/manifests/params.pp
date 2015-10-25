# == Class zabbixagent::params
#
# This class is meant to be called from zabbixagent.
# It sets variables according to platform.
#
class zabbixagent::params {
  $zabbixconf           = '/etc/zabbix/zabbix_agentd.conf'
  $zabbixconf_template  = 'zabbixagent/zabbix_agentd.conf'
  case $::osfamily {
    'Debian': {
      $package_name = 'zabbix-agent'
      $service_name = 'zabbix-agent'
    }
    'RedHat', 'Amazon': {
      $package_name = 'zabbix-agent'
      $service_name = 'zabbix-agent'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
