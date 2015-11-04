# Class: memcached
# ===========================
#
# Full description of class memcached here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class memcached (
  $package_name = $::memcached::params::package_name,
  $service_name = $::memcached::params::service_name,
) inherits ::memcached::params {

  # validate parameters here

  class { '::memcached::install': } ->
  class { '::memcached::config': } ~>
  class { '::memcached::service': } ->
  Class['::memcached']
}
