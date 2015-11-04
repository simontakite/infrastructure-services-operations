#
# EDGESOFT AS
# ___________
#
# [2015] Edgesoft AS - Simon Takite <s307043@stud.hioa.no, simon.takite@gmail.com>
# Distribute. Contribute.
# This file is subject to the terms and conditions defined in Apache 2.0. This project is an assignment at the University of Oslo and Akershus [HiOA] / Oslo University [UiO]
#
# == Class ntp::config
#
# This class is called from ntp for service config.
#
class ntp::config inherits ntp {
  file { $ntp::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($ntp::config_template),
  }
}
