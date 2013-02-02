# == Class: razorsedge::params
#
# This class handles OS-specific configuration of the razorsedge module.  It
# looks for variables in top scope (probably from an ENC such as Dashboard).  If
# the variable doesn't exist in top scope, it falls back to a hard coded default
# value.
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2013 Mike Arnold, unless otherwise noted.
#
class razorsedge::params {
  # If we have a top scope variable defined, use it, otherwise fall back to a
  # hardcoded value.
  $ensure = $::razorsedge_ensure ? {
    undef => 'present',
    default => $::razorsedge_ensure,
  }

  $yum_priority = $::razorsedge_yum_priority ? {
    undef => '50',
    default => $::razorsedge_yum_priority,
  }

  $yum_protect = $::razorsedge_yum_protect ? {
    undef => '0',
    default => $::razorsedge_yum_protect,
  }

  $proxy = $::razorsedge_proxy ? {
    undef => 'absent',
    default => $::razorsedge_proxy,
  }

  $proxy_username = $::razorsedge_proxy_username ? {
    undef => 'absent',
    default => $::razorsedge_proxy_username,
  }

  $proxy_password = $::razorsedge_proxy_password ? {
    undef => 'absent',
    default => $::razorsedge_proxy_password,
  }
}
