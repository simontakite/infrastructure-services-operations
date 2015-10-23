# == Class apache::service
#
# This class is meant to be called from apache.
# It ensure the service is running.
#
class apache::service {

  service { $::apache::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
