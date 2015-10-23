# Class: pound
# ===========================
#
# Full description of class pound here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class pound (
  $default_file		= $::pound::params::default_file,
  $config_file		= $::pound::params::config_file,
  $user			    = $::pound::params::user,
  $group            = $::pound::params::group,
  $alive            = $::pound::params::alive,
  $listen_address   = $::pound::params::listen_address,
  $listen_port		= $::pound::params::listen_port,
  $package_name 	= $::pound::params::package_name,
  $service_name 	= $::pound::params::service_name,
  $config_file_temp = $::pound::params::config_file_temp,
) inherits ::pound::params {

  # validate parameters here

  class { '::pound::install': } ->
  class { '::pound::config': } ~>
  class { '::pound::service': } ->
  Class['::pound']
}
