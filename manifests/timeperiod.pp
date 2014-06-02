# == Define: icinga::command
#
# Wrapper around the nagios_command type
#
# === Parameters
#
# Consult the puppet type reference
#
define icinga::timeperiod (
  $description = undef,
  $sunday = undef,
  $monday = undef,
  $tuesday = undef,
  $wednesday = undef,
  $thursday = undef,
  $friday = undef,
  $saturday = undef,
) {

  nagios_timeperiod { $title:
    alias     => $description,
    sunday    => $sunday,
    monday    => $monday,
    tuesday   => $tuesday,
    wednesday => $wednesday,
    thursday  => $thursday,
    friday    => $friday,
    saturday  => $saturday,
    require   => Class['icinga::server::puppet'],
    notify    => Service['icinga'],
  }

}
