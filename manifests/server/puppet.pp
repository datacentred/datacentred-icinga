# == Class: icinga::server::puppet
#
# Abstract away puppet's quirks as regards naginator
# generated reources
#
class icinga::server::puppet {

  # This is the directory puppet creates the resources
  # in by default, so ensure its existence
  file { '/etc/nagios':
    ensure => directory,
    owner  => 'nagios',
    group  => 'nagios',
    mode   => '0755',
  } ->

  # Create the configuration files with the right
  # permissions and link into the correct locations
  # within icinga
  icinga::server::puppet_file { [
    'nagios_command',
    'nagios_contact',
    'nagios_contactgroup',
    'nagios_host',
    'nagios_hostdependency',
    'nagios_hostescalation',
    'nagios_hostextinfo',
    'nagios_hostgroup',
    'nagios_service',
    'nagios_servicedependency',
    'nagios_serviceescalation',
    'nagios_serviceextinfo',
    'nagios_servicegroup',
    'nagios_timeperiod',
    ]:
  }

  # Clean out any unmanaged files from icinga's
  # object directory
  file { '/etc/icinga/objects':
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

}
