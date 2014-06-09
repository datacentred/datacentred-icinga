datacentred-icinga
==================

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Testing - Guide for contributing to the module](#testing)

## Overview

This module provides a basic frame work for rolling out Icinga monitoring for your network.

## Module Description

This class as it stands creates a standalone monolithic install of the Icinga monitoring daemon, along with a MySQL backed IDO2DB and the Icinga Web front end.  It also provides wrappers around the puppet nagios types which work around known deficiencies.

## Usage

#### Server Installation

The base installation is simply done via

    include icinga::server

It can be configured via puppet data bindings

    icinga::server::allow_empty_hostgroup_assignment: 1
    icinga::server::use_timezone: 'Europe/London'

Or explicitly

    class { 'icinga::server':
      allow_empty_hostgroup_assignment => 1,
      use_timezone                     => 'Europe/London',
    }

You can then define resources to populate the configuration files

    icinga::timeperiod { 'timeperiod_24x7':
      description => '24 hours a day, 7 days a week',
      sunday      => '00:00-24:00',
      monday      => '00:00-24:00',
      tuesday     => '00:00-24:00',
      wednesday   => '00:00-24:00',
      thusday     => '00:00-24:00',
      friday      => '00:00-24:00',
      saturday    => '00:00-24:00',
    }

#### Client Installation

The basic nagios plugins are installed via

    include icinga::client

Hosts can then be defined as such, and will be collected on the server

    @@icinga::host { $::hostname:
      ensure          => present,
      alias           => $::fqdn,
      address         => $::ipaddress,
      use             => 'dc_host_generic',
      hostgroups      => template('dc_icinga/hostgroups.erb'),
      icon_image      => 'base/ubuntu.png',
      icon_image_alt  => 'Ubuntu 14.04 LTS (trusty)',
      notes           => 'Ubuntu 14.04 LTS servers',
      statusmap_image => 'base/ubuntu.gd2',
      vrml_image      => 'ubuntu.png',
    }

Please refer to my [blog post](http://datacentred.co.uk/dynamic-nagios-host-groups-with-puppet/) on dynamically creating hostgroups if the above makes little sense

## Limitations

This class has been tested on Ubuntu 14.04 LTS only.

## Testing

No testing is provided.

