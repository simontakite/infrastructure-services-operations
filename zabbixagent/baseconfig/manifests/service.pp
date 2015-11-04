# == Class baseconfig::service
#
# This class is meant to be called from baseconfig.
# It ensure the service is running.
#
class baseconfig::service {

  service { $::baseconfig::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
