# == Define: icinga::contactgroup
#
# Wrapper around the nagios_contactgroup type
#
# === Parameters
#
# Consult the puppet type reference
#
define icinga::contactgroup (
  $ensure               = present,
  $description          = undef,
  $contactgroup_members = undef,
  $members              = undef,
  $register             = undef,
  $use                  = undef,
) {

  nagios_contactgroup { $title:
    ensure               => $ensure,
    alias                => $description,
    contactgroup_members => $contactgroup_members,
    members              => $members,
    register             => $register,
    use                  => $use,
    require              => Class['icinga::server::puppet'],
    notify               => Service['icinga'],
  }

}
