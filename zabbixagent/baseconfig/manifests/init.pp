# Class: baseconfig
# ===========================
#
# Full description of class baseconfig here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class baseconfig (

  $package_name = $::baseconfig::params::package_name,
  $service_name = $::baseconfig::params::service_name,
  $hostfile     = $::baseconfig::params::hostfile,
  $motdfile     = $::baseconfig::params::motdfile,
  $users        = $::baseconfig::params::users,
  $group        = $::baseconfig::params::group,
  $sudofile     = $::baseconfig::params::sudofile,
  $vimrcfile    = $::baseconfig::params::vimrcfile,

) inherits ::baseconfig::params {

  # validate parameters here

  class { '::baseconfig::install': } ->
  class { '::baseconfig::config': } ~>
  class { '::baseconfig::service': } ->
  Class['::baseconfig']
}
