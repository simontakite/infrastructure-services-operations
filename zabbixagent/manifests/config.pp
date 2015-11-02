# == Class zabbixagent::config
#
# This class is called from zabbixagent for service config.
#
class zabbixagent::config {
	
	file {"/etc/zabbix/zabbix_agent.conf":
		ensure  => 'present',
		mode    => '0644',
		owner   => 'root',
		group   => 'root',
		source  => "puppet:///modules/zabbixagent/zabbix_agent.conf",
		require => Package['zabbix-agent'],
		notify  => Service['zabbix_agentd'],
	}
	
	file {"/etc/zabbix/zabbix_agentd.conf":
		ensure  => 'present',
		mode    => '0644',
		owner   => 'root',
		group   => 'root',
		source  => "puppet:///modules/zabbixagent/zabbix_agentd.conf",
		require => Package['zabbix-agent'],
		notify  => Service['zabbix_agentd'],
	}

}
