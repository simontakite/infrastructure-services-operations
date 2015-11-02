# == Class logstashforwarder::service
#
# This class is meant to be called from logstashforwarder.
# It ensure the service is running.
#
class logstashforwarder::service {

  service { $::logstashforwarder::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['logstash-forwarder'],
  }
}
