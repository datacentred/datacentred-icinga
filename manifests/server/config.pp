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
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source => 'puppet:///modules/icinga/idoutils.cfg',
  }

  # Configure the collection daemon
  file { '/etc/icinga/icinga.cfg':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('icinga/icinga.cfg.erb'),
  }

  # Install the puppet naginator workarounds
  contain icinga::server::puppet

  # Collect any exported host definitions
  Icinga::Host <<||>> {
    require => Class['icinga::server::puppet'],
  }

}

