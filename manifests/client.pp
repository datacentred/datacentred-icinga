# == Class: icinga::client
#
# Installs the requisite plugins to provide monitoring
#
class icinga::client {

  ensure_packages('nagios-plugins')

}
