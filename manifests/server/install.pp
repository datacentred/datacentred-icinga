# == Class: icinga::server::install
#
# Installs a monolithic icinga instance with database
# the core monitoring component and the web frontend
#
class icinga::server::install {

  include ::mysql::server

  # These packages will install the databases *locally*
  # so ensure that MySQL is installed and running before
  # dbconfig runs during install
  package { [
    'icinga-core',
    'icinga-web',
    ]:
    ensure  => installed,
    require => Service['mysqld'],
  }

  # So we can probe others
  package { 'nagios-nrpe-plugin':
    ensure  => present,
  }

}
