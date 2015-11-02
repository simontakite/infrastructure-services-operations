# Class: zabbixagent
# ===========================
#
# Full description of class zabbixagent here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class zabbixagent (

  $package_name 	= $::zabbixagent::params::package_name,
  $service_name 	= $::zabbixagent::params::service_name,
  $zabbixconf 		= $::zabbixagent::params::zabbixconf,
  $zabbixconf_template 	= $::zabbixagent::params::zabbixconf_template,
  $zabbixconfd 		= $::zabbixagent::params::zabbixconfd,
  $zabbixconfd_template = $::zabbixagent::params::zabbixconf_template,

) inherits ::zabbixagent::params {

  # validate parameters here

  class { '::zabbixagent::install': } ->
  class { '::zabbixagent::config': } ~>
  class { '::zabbixagent::service': } ->
  Class['::zabbixagent']
}
