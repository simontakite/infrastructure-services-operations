# == Class zabbixagent::config
#
# This class is called from zabbixagent for service config.
#
class zabbixagent::config {

    file { $::zabbixagent::zabbixconf:
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template($zabbixagent::zabbixconf_template),
    }

    file { $::zabbixagent::zabbixconfd:
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template($zabbixagent::zabbixconfd_template),
    }
}
