# == Class baseconfig::config
#
# This class is called from baseconfig for service config.
#
class baseconfig::config {

  file { $::baseconfig::motdfile:
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/baseconfig/motd',
  }

  file { $::baseconfig::sudofile:
    ensure  => 'file',
    group   => '0',
    mode    => '0440',
    owner   => '0',
    source  => 'puppet:///modules/baseconfig/sudoers',
  }

  file { $::baseconfig::vimrcfile:
    ensure  => 'file',
    group   => '0',
    mode    => '0644',
    owner   => '0',
    source  => 'puppet:///modules/baseconfig/vimrc',
  }

  group { $::baseconfig::group:
    ensure  => 'present',
    gid     => '1001',
  }

  user { 'janet':
    ensure  => 'present',
    comment => 'janet,,,',
    gid     => '1001',
    groups  => ['sudo', 'webadmins'],
    home    => '/home/janet',
    shell   => '/bin/bash',
    password => '$1$9l680kjZ$heTOkf0wykdRTqdP4jIvw/',
    uid     => '1003',
  }

  user { 'tom':
    ensure  => 'present',
    comment => 'tom,,,',
    gid     => '1001',
    groups  => ['sudo', 'webadmins'],
    home    => '/home/tom',
    shell   => '/bin/bash' ,
    password => '$1$9l680kjZ$heTOkf0wykdRTqdP4jIvw/',
    uid     => '1004',
  }

  user { 'brady':
    ensure  => 'present',
    comment => 'brady,,,',
    gid     => '1001',
    groups  => ['sudo', 'webadmins'],
    home    => '/home/brady',
    shell   => '/bin/bash',
    password => '$1$9l680kjZ$heTOkf0wykdRTqdP4jIvw/',
    uid     => '1005',
  }

  cron { "puppetagent":
    ensure  => present,
    command => 'puppet agent --test',
    user    => root,
    hour    => '*',
    minute  => '*/30',
  }

}
