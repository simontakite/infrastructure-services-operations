#
# EDGESOFT AS
# ___________
#
# [2015] Edgesoft AS - Simon Takite <s307043@stud.hioa.no, simon.takite@gmail.com>
# Distribute. Contribute.
# This file is subject to the terms and conditions defined in Apache 2.0. This project is an assignment at the University of Oslo and Akershus [HiOA] / Oslo University [UiO]
## == Class ntp::install
#
# This class is called from ntp for install.
#
class ntp::install {

  package { $::ntp::package_name:
    ensure => present,
  }
}
