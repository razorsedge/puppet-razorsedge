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
  $razorsedge_ensure = getvar('::razorsedge_ensure')
  if $razorsedge_ensure {
    $ensure = $::razorsedge_ensure
  } else {
    $ensure = 'present'
  }

  $razorsedge_enable_test = getvar('::razorsedge_enable_test')
  if $razorsedge_enable_test {
    $enable_test = $::razorsedge_enable_test
  } else {
    $enable_test = false
  }
  if is_string($enable_test) {
    $safe_enable_test = str2bool($enable_test)
  } else {
    $safe_enable_test = $enable_test
  }

  $razorsedge_reposerver = getvar('::razorsedge_reposerver')
  if $razorsedge_reposerver {
    $reposerver = $::razorsedge_reposerver
  } else {
    $reposerver = 'http://rpm.razorsedge.org'
  }

  $razorsedge_yum_priority = getvar('::razorsedge_yum_priority')
  if $razorsedge_yum_priority {
    $yum_priority = $::razorsedge_yum_priority
  } else {
    $yum_priority = '50'
  }

  $razorsedge_yum_protect = getvar('::razorsedge_yum_protect')
  if $razorsedge_yum_protect {
    $yum_protect = $::razorsedge_yum_protect
  } else {
    $yum_protect = '0'
  }

  $razorsedge_proxy = getvar('::razorsedge_proxy')
  if $razorsedge_proxy {
    $proxy = $::razorsedge_proxy
  } else {
    $proxy = 'absent'
  }

  $razorsedge_proxy_username = getvar('::razorsedge_proxy_username')
  if $razorsedge_proxy_username {
    $proxy_username = $::razorsedge_proxy_username
  } else {
    $proxy_username = 'absent'
  }

  $razorsedge_proxy_password = getvar('::razorsedge_proxy_password')
  if $razorsedge_proxy_password {
    $proxy_password = $::razorsedge_proxy_password
  } else {
    $proxy_password = 'absent'
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
    $repopath = "/el-${majdistrelease}"
  } elsif $::osfamily == 'RedHat' and $::operatingsystem == 'Fedora' {
    $repopath = "/fedora-${::operatingsystemrelease}"
  } else {
    notice("Your operating system ${::operatingsystem} will not have the RazorsEdge repository applied.")
  }
}
