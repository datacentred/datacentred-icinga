# == Class: icinga::client
#
# Installs the requisite plugins to provide monitoring
#
class icinga::client {

  package { 'nagios-plugins':
    ensure => present,
  }

}
