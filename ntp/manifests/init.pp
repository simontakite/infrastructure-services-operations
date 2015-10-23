#
# EDGESOFT AS
# ___________
#
# [2015] Edgesoft AS - Simon Takite <s307043@stud.hioa.no, simon.takite@gmail.com>
# Distribute. Contribute.
# This file is subject to the terms and conditions defined in Apache 2.0. This project is an assignment at the University of Oslo and Akershus [HiOA] / Oslo University [UiO]
#
# Class: ntp
# ===========================
#
# Full description of class ntp here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class ntp (
  $package_name     = $::ntp::params::package_name,
  $service_name     = $::ntp::params::service_name,
  $servers          = $::ntp::params::servers,
  $config           = $::ntp::params::config,
  $config_template  = $::ntp::params::config_template,

) inherits ::ntp::params {

  # validate parameters here

  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  Class['::ntp']
}
