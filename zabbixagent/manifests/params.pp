# == Class zabbixagent::params
#
# This class is meant to be called from zabbixagent.
# It sets variables according to platform.
#
class zabbixagent::params {

  $zabbixconf           	= '/etc/zabbix/zabbix_agent.conf'
  $zabbixconfd           	= '/etc/zabbix/zabbix_agentd.conf'

  case $::osfamily {
    'Debian': {
      $package_name = 'zabbix-agent'
      $service_name = 'zabbix_agentd'
    }
    'RedHat', 'Amazon': {
      $package_name = 'zabbix-agent'
      $service_name = 'zabbix_agentd'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
