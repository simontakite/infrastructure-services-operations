# Class: nodejs
# ===========================
#
# Full description of class nodejs here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class nodejs (
  $package_name = $::nodejs::params::package_name,
  $service_name = $::nodejs::params::service_name,
) inherits ::nodejs::params {

  # validate parameters here

  class { '::nodejs::install': } ->
  class { '::nodejs::config': } ~>
  class { '::nodejs::service': } ->
  Class['::nodejs']
}
