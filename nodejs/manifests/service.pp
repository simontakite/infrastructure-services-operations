# == Class nodejs::service
#
# This class is meant to be called from nodejs.
# It ensure the service is running.
#
class nodejs::service {

  service { $::nodejs::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
