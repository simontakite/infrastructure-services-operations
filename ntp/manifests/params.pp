#
# EDGESOFT AS
# ___________
#
# [2015] Edgesoft AS - Simon Takite <s307043@stud.hioa.no, simon.takite@gmail.com>
# Distribute. Contribute.
# This file is subject to the terms and conditions defined in Apache 2.0. This project is an assignment at the University of Oslo and Akershus [HiOA] / Oslo University [UiO]
#
# == Class ntp::params
#
# This class is meant to be called from ntp.
# It sets variables according to platform.
#
class ntp::params {
  $config = '/etc/ntp.conf'
  $config_template = 'ntp/ntp.conf.erb'
  case $::osfamily {
    'Debian': {
      $package_name = 'ntp'
      $service_name = 'ntp'
      $servers         = [
        '0.no.pool.ntp.org',
        '1.no.pool.ntp.org',
        '2.no.pool.ntp.org',
        '3.no.pool.ntp.org',
      ]
      $fallback_server = 'ntp.ubuntu.com'

    }
    'RedHat', 'Amazon': {
      $package_name = 'ntp'
      $service_name = 'ntp'
      $servers         = [
        '0.no.pool.ntp.org',
        '1.no.pool.ntp.org',
        '2.no.pool.ntp.org',
        '3.no.pool.ntp.org',
      ]
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
