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

}
