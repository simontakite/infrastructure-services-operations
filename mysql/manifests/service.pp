# == Class mysql::service
#
# This class is meant to be called from mysql.
# It ensure the service is running.
#
class mysql::service {

  service { $::mysql::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
