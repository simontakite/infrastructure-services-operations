# == Class logstashforwarder::config
#
# This class is called from logstashforwarder for service config.
#
# - See more at: http://siddou.tk/2015/05/install-logstash-forwarder-with-puppet-on-debian-8-jessie/#sthash.XWi3OHk1.dpuf

class logstashforwarder::config {

	file { "/etc/logstash-forwarder.conf":
        	ensure 		=> present,
        	owner   	=> root,
        	group   	=> root,
        	mode    	=> 0644,
          	source  	=> 'puppet:///modules/logstashforwarder/logstash-forwarder.conf',
		require 	=> Package['logstash-forwarder'],
        #	notify 		=> Service['logstash-forwarder'],
	}
 
	file { "/etc/pki/tls/certs/logstash-forwarder.crt":
        	ensure 		=> present,
        	owner   	=> root,
        	group   	=> root,
        	mode    	=> 0644,
        	source  	=> 'puppet:///modules/logstashforwarder/logstash-forwarder.crt',
		require 	=> Package['logstash-forwarder'],
        #	notify 		=> Service['logstash-forwarder'],
	}

}
