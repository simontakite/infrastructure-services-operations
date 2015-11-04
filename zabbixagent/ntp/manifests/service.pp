#
# EDGESOFT AS
# ___________
#
# [2015] Edgesoft AS - Simon Takite <s307043@stud.hioa.no, simon.takite@gmail.com>
# Distribute. Contribute.
# This file is subject to the terms and conditions defined in Apache 2.0. This project is an assignment at the University of Oslo and Akershus [HiOA] / Oslo University [UiO]
#
# == Class ntp::service
#
# This class is meant to be called from ntp.
# It ensure the service is running.
#
class ntp::service {

  service { $::ntp::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
