# == Class logstashforwarder::config
#
# This class is called from logstashforwarder for service config.
#
# - See more at: http://siddou.tk/2015/05/install-logstash-forwarder-with-puppet-on-debian-8-jessie/#sthash.XWi3OHk1.dpuf

class logstashforwarder::config {

	apt::source { 'logstashforwarder':
		location            	=> 'http://packages.elasticsearch.org/logstashforwarder/debian',
		release          	=> 'stable',
		repos               	=> 'main',
		key             	=> {
			id         	=> '46095ACC8548582C1A2699A9D27D666CD88E42B4',
			source 		=> 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
			},
		notify => Package ['logstash-forwarder'],
	}
	
	file { "/etc/logstash-forwarder.conf":
        	ensure 		=> present,
        	owner   	=> root,
        	group   	=> root,
        	mode    	=> 0644,
          	source  	=> 'puppet:///modules/logstashforwarder/logstash-forwarder.conf',
        	require 	=> Package['logstash-forwarder'],
        	notify 		=> Service['logstash-forwarder'],
	}
 
	file { "/etc/pki/tls/certs/logstash-forwarder.crt":
        	ensure 		=> present,
        	owner   	=> root,
        	group   	=> root,
        	mode    	=> 0644,
        	source  	=> 'puppet:///modules/logstashforwarder/logstash-forwarder.crt',
        	require 	=> Package['logstash-forwarder'],
        	notify 		=> Service['logstash-forwarder'],
	}

}
