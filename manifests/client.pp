class icinga::client {

  package { 'nagios-plugins':
    ensure => present,
  }

}
