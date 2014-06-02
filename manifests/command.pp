# == Define: icinga::command
#
# Wrapper around the nagios_command type
#
# === Parameters
#
# Consult the puppet type reference
#
define icinga::command (
  $ensure       = present,
  $command_line = undef,
  $poller_tag   = undef,
  $use          = undef,
) {

  nagios_command { $title:
    ensure       => $ensure,
    command_line => $command_line,
    poller_tag   => $poller_tag,
    use          => $use,
    require      => Class['icinga::server::puppet'],
    notify       => Service['icinga'],
  }

}
