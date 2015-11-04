# Class: php
# ===========================
#
# Full description of class php here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class php (
  $package_name = $::php::params::package_name,
) inherits ::php::params {

  # validate parameters here

  class { '::php::install': } ->
  class { '::php::config': } ~>
  Class['::php']
}
