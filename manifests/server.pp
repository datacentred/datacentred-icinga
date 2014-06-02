# == Class: icinga::server
#
# Installs a monolithic Icinga server instance
#
class icinga::server {

  contain icinga::server::install
  contain icinga::server::config
  contain icinga::server::service

  Class['icinga::server::install'] ->
  Class['icinga::server::config'] ~>
  Class['icinga::server::service']

}
