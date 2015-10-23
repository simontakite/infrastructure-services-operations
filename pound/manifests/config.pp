# == Class pound::config
#
# This class is called from pound for service config.
#
class pound::config {
  file { $::pound::config_file:
    ensure  => 'file',
    group   => '0',
    mode    => '0644',
    owner   => '0',
    content => template($pound::config_file_temp),
    require => Package[$::pound::package_name],
  }
  file { $::pound::default_file:
    ensure  => 'file',
    group   => '0',
    mode    => '0644',
    owner   => '0',
    source  => 'puppet:///modules/pound/pound',
  }
}
