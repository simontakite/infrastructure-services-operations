# == Class zabbixagent::service
#
# This class is meant to be called from zabbixagent.
# It ensure the service is running.
#
class zabbixagent::service {

  service { $::zabbixagent::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
