# == Class pound::service
#
# This class is meant to be called from pound.
# It ensure the service is running.
#
class pound::service {

  service { $::pound::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
