# Class: logstashforwarder
# ===========================
#
# Full description of class logstashforwarder here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class logstashforwarder (
  $package_name = $::logstashforwarder::params::package_name,
  $service_name = $::logstashforwarder::params::service_name,
) inherits ::logstashforwarder::params {

  # validate parameters here

  class { '::logstashforwarder::install': } ->
  class { '::logstashforwarder::config': } ~>
  class { '::logstashforwarder::service': } ->
  Class['::logstashforwarder']
}
