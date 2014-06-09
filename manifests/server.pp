# == Class: icinga::server
#
# Installs a monolithic Icinga server instance
#
# === Parameters
#
# Those without explicit documentation are passed straight through
# to icinga.cfg so consult the icinga documentation for their
# significance
#
# === Examples
#
# ==== Explicit Parameterization
#
# class { 'icinga::server':
#   allow_empty_hostgroup_assignment => 1,
#   use_timezone                     => 'Europe/London',
# }
#
# ==== Implicit Parameterization
#
# Puppet manifest:
#
# include icinga::server
#
# Hiera:
#
# icinga::server::allow_empty_hostgroup_assignment: 1
# icinga::server::use_timezone: 'Europe/London'
#
class icinga::server (
  $log_file = '/var/log/icinga/icinga.log',
  $cfg_file = '/etc/icinga/commands.cfg',
  $cfg_dir = [
    '/etc/nagios-plugins/config',
    '/etc/icinga/objects/',
    '/etc/icinga/modules',
  ],
  $object_cache_file = '/var/cache/icinga/objects.cache',
  $precached_object_file = '/var/cache/icinga/objects.precache',
  $resource_file = '/etc/icinga/resource.cfg',
  $status_file = '/var/lib/icinga/status.dat',
  $status_update_interval = 10,
  $icinga_user = 'nagios',
  $icinga_group = 'nagios',
  $check_external_commands = 0,
  $command_check_interval = -1,
  $command_file = '/var/lib/icinga/rw/icinga.cmd',
  $external_command_buffer_slots = 4096,
  $lock_file = '/var/run/icinga/icinga.pid',
  $temp_file = '/var/cache/icinga/icinga.tmp',
  $temp_path = '/tmp',
  $event_broker_options = -1,
  $log_rotation_method = 'd',
  $log_archive_path = '/var/log/icinga/archives',
  $use_daemon_log = 1,
  $use_syslog = 1,
  $use_syslog_local_facility = 0,
  $syslog_local_facility = 5,
  $log_notifications = 1,
  $log_service_retries = 1,
  $log_host_retries = 1,
  $log_event_handlers = 1,
  $log_initial_states = 0,
  $log_current_states = 1,
  $log_external_commands = 1,
  $log_passive_checks = 1,
  $log_long_plugin_output = 0,
  $service_inter_check_delay_method = 's',
  $max_service_check_spread = 30,
  $service_interleave_factor = 's',
  $host_inter_check_delay_method = 's',
  $max_host_check_spread = 30,
  $max_concurrent_checks = 0,
  $check_result_reaper_frequency = 10,
  $max_check_result_reaper_time = 30,
  $check_result_path = '/var/lib/icinga/spool/checkresults',
  $max_check_result_file_age = 3600,
  $cached_host_check_horizon = 15,
  $cached_service_check_horizon = 15,
  $enable_predictive_host_dependency_checks = 1,
  $enable_predictive_service_dependency_checks = 1,
  $soft_state_dependencies = 0,
  $auto_reschedule_checks = 0,
  $auto_rescheduling_interval = 30,
  $auto_rescheduling_window = 180,
  $sleep_time = 0.25,
  $service_check_timeout = 60,
  $host_check_timeout = 30,
  $event_handler_timeout = 30,
  $notification_timeout = 30,
  $ocsp_timeout = 5,
  $perfdata_timeout = 5,
  $retain_state_information = 1,
  $state_retention_file = '/var/cache/icinga/retention.dat',
  $retention_update_interval = 60,
  $use_retained_program_state = 1,
  $dump_retained_host_service_states_to_neb = 0,
  $use_retained_scheduling_info = 1,
  $retained_host_attribute_mask = 0,
  $retained_service_attribute_mask = 0,
  $retained_process_host_attribute_mask = 0,
  $retained_process_service_attribute_mask = 0,
  $retained_contact_host_attribute_mask = 0,
  $retained_contact_service_attribute_mask = 0,
  $interval_length = 60,
  $use_aggressive_host_checking = 0,
  $execute_service_checks = 1,
  $accept_passive_service_checks = 1,
  $execute_host_checks = 1,
  $accept_passive_host_checks = 1,
  $enable_notifications = 1,
  $enable_event_handlers = 1,
  $process_performance_data = 0,
  $allow_empty_hostgroup_assignment = 0,
  $obsess_over_services = 0,
  $obsess_over_hosts = 0,
  $translate_passive_host_checks = 0,
  $passive_host_checks_are_soft = 0,
  $check_for_orphaned_services = 1,
  $check_for_orphaned_hosts = 1,
  $service_check_timeout_state = 'u',
  $check_service_freshness = 1,
  $service_freshness_check_interval = 60,
  $check_host_freshness = 0,
  $host_freshness_check_interval = 60,
  $additional_freshness_latency = 15,
  $enable_flap_detection = 1,
  $low_service_flap_threshold = 5.0,
  $high_service_flap_threshold = 20.0,
  $low_host_flap_threshold = 5.0,
  $high_host_flap_threshold = 20.0,
  $date_format = 'iso8601',
  $use_timezone = 'UTC',
  $p1_file = '/usr/lib/icinga/p1.pl',
  $enable_embedded_perl = 1,
  $use_embedded_perl_implicitly = 1,
  $stalking_event_handlers_for_hosts = 0,
  $stalking_event_handlers_for_services = 0,
  $stalking_notifications_for_hosts = 0,
  $stalking_notifications_for_services = 0,
  $illegal_object_name_chars = '`~!$%^&*|\'"<>?,()=:',
  $illegal_macro_output_chars = '`~$&|\'"<>',
  $keep_unknown_macros = 0,
  $use_regexp_matching = 0,
  $use_true_regexp_matching = 0,
  $admin_email = 'root@localhost',
  $admin_pager = 'pageroot@localhost',
  $daemon_dumps_core = 0,
  $use_large_installation_tweaks = 0,
  $enable_environment_macros = 1,
  $debug_level = 0,
  $debug_verbosity = 2,
  $debug_file = '/var/log/icinga/icinga.debug',
  $max_debug_file_size = 100000000,
  $event_profiling_enabled = 0,
) {

  $regex_int = '^-?\d+$'
  $regex_float = '^-?\d+\.\d+$'

  validate_absolute_path($log_file)
  validate_absolute_path($cfg_file)
  validate_array($cfg_dir)
  validate_absolute_path($object_cache_file)
  validate_absolute_path($precached_object_file)
  validate_absolute_path($resource_file)
  validate_absolute_path($status_file)
  validate_re("${status_update_interval}", $regex_int)
  validate_string($icinga_user)
  validate_string($icinga_group)
  validate_re("${$check_external_commands}", $regex_int)
  validate_re("${command_check_interval}", $regex_int)
  validate_absolute_path($command_file)
  validate_re("${external_command_buffer_slots}", $regex_int)
  validate_absolute_path($lock_file)
  validate_absolute_path($temp_file)
  validate_absolute_path($temp_path)
  validate_re("${event_broker_options}", $regex_int)
  validate_re($log_rotation_method, '^[nhdwm]$')
  validate_absolute_path($log_archive_path)
  validate_re("${use_daemon_log}", $regex_int)
  validate_re("${use_syslog}", $regex_int)
  validate_re("${use_syslog_local_facility}", $regex_int)
  validate_re("${syslog_local_facility}", $regex_int)
  validate_re("${log_notifications}", $regex_int)
  validate_re("${log_service_retries}", $regex_int)
  validate_re("${log_host_retries}", $regex_int)
  validate_re("${log_event_handlers}", $regex_int)
  validate_re("${log_initial_states}", $regex_int)
  validate_re("${log_current_states}", $regex_int)
  validate_re("${log_external_commands}", $regex_int)
  validate_re("${log_passive_checks}", $regex_int)
  validate_re("${log_long_plugin_output}", $regex_int)
  validate_re($service_inter_check_delay_method, '^([nds]|\d\.\d\d)$')
  validate_re("${max_service_check_spread}", $regex_int)
  validate_re($service_interleave_factor, '^(s|\d+)$')
  validate_re($host_inter_check_delay_method, '^([nds]|\d\.\d\d)$')
  validate_re("${max_host_check_spread}", $regex_int)
  validate_re("${max_concurrent_checks}", $regex_int)
  validate_re("${check_result_reaper_frequency}", $regex_int)
  validate_re("${max_check_result_reaper_time}", $regex_int)
  validate_absolute_path($check_result_path)
  validate_re("${max_check_result_file_age}", $regex_int)
  validate_re("${cached_host_check_horizon}", $regex_int)
  validate_re("${cached_service_check_horizon}", $regex_int)
  validate_re("${enable_predictive_host_dependency_checks}", $regex_int)
  validate_re("${enable_predictive_service_dependency_checks}", $regex_int)
  validate_re("${soft_state_dependencies}", $regex_int)
  validate_re("${auto_reschedule_checks}", $regex_int)
  validate_re("${auto_rescheduling_interval}", $regex_int)
  validate_re("${auto_rescheduling_window}", $regex_int)
  validate_re("${sleep_time}", $regex_float)
  validate_re("${service_check_timeout}", $regex_int)
  validate_re("${host_check_timeout}", $regex_int)
  validate_re("${event_handler_timeout}", $regex_int)
  validate_re("${notification_timeout}", $regex_int)
  validate_re("${ocsp_timeout}", $regex_int)
  validate_re("${perfdata_timeout}", $regex_int)
  validate_re("${retain_state_information}", $regex_int)
  validate_absolute_path($state_retention_file)
  validate_re("${retention_update_interval}", $regex_int)
  validate_re("${use_retained_program_state}", $regex_int)
  validate_re("${dump_retained_host_service_states_to_neb}", $regex_int)
  validate_re("${use_retained_scheduling_info}", $regex_int)
  validate_re("${retained_host_attribute_mask}", $regex_int)
  validate_re("${retained_service_attribute_mask}", $regex_int)
  validate_re("${retained_process_host_attribute_mask}", $regex_int)
  validate_re("${retained_process_service_attribute_mask}", $regex_int)
  validate_re("${retained_contact_host_attribute_mask}", $regex_int)
  validate_re("${retained_contact_service_attribute_mask}", $regex_int)
  validate_re("${interval_length}", $regex_int)
  validate_re("${use_aggressive_host_checking}", $regex_int)
  validate_re("${execute_service_checks}", $regex_int)
  validate_re("${accept_passive_service_checks}", $regex_int)
  validate_re("${execute_host_checks}", $regex_int)
  validate_re("${accept_passive_host_checks}", $regex_int)
  validate_re("${enable_notifications}", $regex_int)
  validate_re("${enable_event_handlers}", $regex_int)
  validate_re("${process_performance_data}", $regex_int)
  validate_re("${allow_empty_hostgroup_assignment}", $regex_int)
  validate_re("${obsess_over_services}", $regex_int)
  validate_re("${obsess_over_hosts}", $regex_int)
  validate_re("${translate_passive_host_checks}", $regex_int)
  validate_re("${passive_host_checks_are_soft}", $regex_int)
  validate_re("${check_for_orphaned_services}", $regex_int)
  validate_re("${check_for_orphaned_hosts}", $regex_int)
  validate_re($service_check_timeout_state, '^[cuwo]$')
  validate_re("${check_service_freshness}", $regex_int)
  validate_re("${service_freshness_check_interval}", $regex_int)
  validate_re("${check_host_freshness}", $regex_int)
  validate_re("${host_freshness_check_interval}", $regex_int)
  validate_re("${additional_freshness_latency}", $regex_int)
  validate_re("${enable_flap_detection}", $regex_int)
  validate_re("${low_service_flap_threshold}", $regex_float)
  validate_re("${high_service_flap_threshold}", $regex_float)
  validate_re("${low_host_flap_threshold}", $regex_float)
  validate_re("${high_host_flap_threshold}", $regex_float)
  validate_re($date_format, '^(us|euro|iso8601|strict-iso8601)$')
  validate_string($use_timezone)
  validate_absolute_path($p1_file)
  validate_re("${enable_embedded_perl}", $regex_int)
  validate_re("${use_embedded_perl_implicitly}", $regex_int)
  validate_re("${stalking_event_handlers_for_hosts}", $regex_int)
  validate_re("${stalking_event_handlers_for_services}", $regex_int)
  validate_re("${stalking_notifications_for_hosts}", $regex_int)
  validate_re("${stalking_notifications_for_services}", $regex_int)
  validate_string($illegal_object_name_chars)
  validate_string($illegal_macro_output_chars)
  validate_re("${keep_unknown_macros}", $regex_int)
  validate_re("${use_regexp_matching}", $regex_int)
  validate_re("${use_true_regexp_matching}", $regex_int)
  validate_string($admin_email)
  validate_string($admin_pager)
  validate_re("${daemon_dumps_core}", $regex_int)
  validate_re("${use_large_installation_tweaks}", $regex_int)
  validate_re("${enable_environment_macros}", $regex_int)
  validate_re("${debug_level}", $regex_int)
  validate_re("${debug_verbosity}", $regex_int)
  validate_absolute_path($debug_file)
  validate_re("${max_debug_file_size}", $regex_int)
  validate_re("${event_profiling_enabled}", $regex_int)

  contain icinga::server::install
  contain icinga::server::config
  contain icinga::server::service

  Class['icinga::server::install'] ->
  Class['icinga::server::config'] ~>
  Class['icinga::server::service']

}
