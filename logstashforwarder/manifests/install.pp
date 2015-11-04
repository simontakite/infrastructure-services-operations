# == Class logstashforwarder::install
#
# This class is called from logstashforwarder for install.
#
class logstashforwarder::install {

	package { "logstash-forwarder":
		name 		=> "logstash-forwarder",
        	ensure		=> installed,
        	provider	=> dpkg,
          	source  	=> 'puppet:///modules/logstashforwarder/logstash-forwarder_0.4.0_amd64.deb',
#		notify		=> Package ['logstash-forwarder'],
	}

}
