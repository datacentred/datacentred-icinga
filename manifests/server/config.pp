# == Class: icinga::server::config
#
# Configures icinga services and configuration files
#
class icinga::server::config {

  # ido2db is disabled by default on Ubuntu so turn it on
  augeas { 'ido2db':
    context => '/files/etc/default/icinga',
    changes => 'set IDO2DB yes',
  }

  # Install the icinga ido2db module
  file { '/etc/icinga/modules/idoutils.cfg':
    ensure => file,
    source => 'puppet:///modules/icinga/idoutils.cfg',
  }

  # Install the puppet naginator workarounds
  contain icinga::server::puppet

  # Collect any exported host definitions
  Icinga::Host <<||>> {
    require => Class['icinga::server::puppet'],
  }

}

