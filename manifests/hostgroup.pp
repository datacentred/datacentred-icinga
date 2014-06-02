# == Define: icinga::hostgroup
#
# Wrapper around the nagios_hostgroup type
#
# === Parameters
#
# Consult the puppet type reference
#
define icinga::hostgroup (
  $ensure            = present,
  $action_url        = undef,
  $description       = undef,
  $hostgroup_members = undef,
  $members           = undef,
  $notes             = undef,
  $notes_url         = undef,
  $realm             = undef,
  $register          = undef,
  $use               = undef,
) {

  nagios_hostgroup { $title:
    ensure            => $ensure,
    action_url        => $action_url,
    alias             => $description,
    hostgroup_members => $hostgroup_members,
    members           => $members,
    notes             => $notes,
    notes_url         => $notes_url,
    realm             => $realm,
    register          => $register,
    use               => $use,
    require           => Class['icinga::server::puppet'],
    notify            => Service['icinga'],
  }

}
