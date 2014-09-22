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

  $enable_test = $::razorsedge_enable_test ? {
    undef => false,
    default => $::razorsedge_enable_test,
  }
  if is_string($enable_test) {
    $safe_enable_test = str2bool($enable_test)
  } else {
    $safe_enable_test = $enable_test
  }

  $yum_server = $::razorsedge_yum_server ? {
    undef   => 'http://rpm.razorsedge.org',
    default => $::razorsedge_yum_server,
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

  if $::operatingsystemmajrelease { # facter 1.7+
    $majdistrelease = $::operatingsystemmajrelease
  } elsif $::lsbmajdistrelease {    # requires LSB to already be installed
    $majdistrelease = $::lsbmajdistrelease
  } elsif $::os_maj_version {       # requires stahnma/epel
    $majdistrelease = $::os_maj_version
  } else {
    $majdistrelease = regsubst($::operatingsystemrelease,'^(\d+)\.(\d+)','\1')
  }

  if $::osfamily == 'RedHat' and $::operatingsystem != 'Fedora' {
    $yum_path = "/el-${majdistrelease}"
  } elsif $::osfamily == 'RedHat' and $::operatingsystem == 'Fedora' {
    $yum_path = "/fedora-${::operatingsystemrelease}"
  } else {
    notice("Your operating system ${::operatingsystem} will not have the RazorsEdge repository applied.")
  }
}
