# == Define: icinga::server::puppet_file
#
# Manages a single puppet naginator file.  This involves
# setting permissions so icinga can read the configuration
# and linking it into the icinga configuration directory
#
# === Parameters
#
# [*title*]
#   The puppet nagios type to manage e.g. nagios_host
#
# === Examples
#
# icinga::server::puppet_file { 'nagios_hostgroup': }
#
define icinga::server::puppet_file {

  # Where puppet's managed files will be linked to in
  # the icinga directory structure to maintain some
  # form of normality with what icinga users are expecting
  $link_src_path = $title ? {
    'nagios_command' => '/etc/icinga/commands.cfg',
    default          => "/etc/icinga/objects/${title}.cfg"
  }

  # Ensure the generated files are readable by the
  # icinga process
  file { "/etc/nagios/${title}.cfg":
    ensure => present,
    owner  => 'nagios',
    group  => 'nagios',
    mode   => '0644',
    notify => Service['icinga'],
  }

  # Link into the default icinga directory structure
  file { $link_src_path:
    ensure => link,
    target => "/etc/nagios/${title}.cfg"
  }

  # Purge resources when they are removed from puppetdb
  resources { $title:
    purge  => true,
    notify => Service['icinga'],
  }

}
