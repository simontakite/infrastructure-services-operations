# Class: mysql
# ===========================
#
# Full description of class mysql here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class mysql (
  $package_name = $::mysql::params::package_name,
  $service_name = $::mysql::params::service_name,
  $myconf       = $::mysql::params::mycnf,
) inherits ::mysql::params {

  # validate parameters here

  class { '::mysql::install': } ->
  class { '::mysql::config': } ~>
  class { '::mysql::service': } ->
  Class['::mysql']
}
