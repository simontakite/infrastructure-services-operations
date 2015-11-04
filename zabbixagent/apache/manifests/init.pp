# Class: apache
# ===========================
#
# Full description of class apache here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class apache (
  $package_name = $::apache::params::package_name,
  $service_name = $::apache::params::service_name,
) inherits ::apache::params {

  # validate parameters here

  class { '::apache::install': } ->
  class { '::apache::config': } ~>
  class { '::apache::service': } ->
  Class['::apache']
}
