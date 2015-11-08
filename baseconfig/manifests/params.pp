# == Class baseconfig::params
#
# This class is meant to be called from baseconfig.
# It sets variables according to platform.
#
class baseconfig::params {
  $hostfile         = '/etc/hosts'
  $motdfile         = '/etc/motd'
  $sudofile         = '/etc/sudoers'
  $vimrcfile        = '/etc/vim/vimrc'
  $host_template    = 'baseconfig/hosts.erb'
  $group            = 'webadmins'

  case $::osfamily {
    'Debian': {
      $package_name = ['vim', 'puppet', 'git']
      $service_name = ['cron']
    }
    'RedHat', 'Amazon': {
      $package_name = ['vim', 'puppet', 'git']
      $service_name = ['cron']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
