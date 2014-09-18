# == Class: icinga::server::service
#
# Ensures the icinga and ido2db services are running
#
class icinga::server::service {

  service { [
    'ido2db',
    'icinga',
    ]:
    ensure => running,
  }

  # Unbeknownst to me, ido2db must (re)start before icinga
  Service['ido2db'] -> Service['icinga']

}
