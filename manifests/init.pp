# == Class: razorsedge
#
# This class handles installing the RazorsEdge YUM repositories and GPG key.
#
# === Parameters:
#
# [*ensure*]
#   Ensure if present or absent.
#   Default: present
#
# [*enable_test*]
#   Enable the RE-test repo.
#   Default: false
#
# [*reposerver*]
#   URI of the YUM server.
#   Default: http://rpm.razorsedge.org
#
# [*repopath*]
#   The path to add to the $reposerver URI.
#   Only set this if your platform is not supported or you know what you are
#   doing.
#   Default: auto-set, platform specific
#
# [*priority*]
#   Give packages in this YUM repository a different weight.  Requires
#   yum-plugin-priorities to be installed.
#   Default: 50
#
# [*protect*]
#   Protect packages in this YUM repository from being overridden by packages
#   in non-protected repositories.
#   Default: 0 (false)
#
# [*proxy*]
#   The URL to the proxy server for this repository.
#   Default: absent
#
# [*proxy_username*]
#   The username for the proxy.
#   Default: absent
#
# [*proxy_password*]
#   The password for the proxy.
#   Default: absent
#
# === Requires:
#
#  gpg_key provider
#
# === Sample Usage:
#
#  class { razorsedge: }
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2013 Mike Arnold, unless otherwise noted.
#
class razorsedge (
  $ensure         = $razorsedge::params::ensure,
  $enable_test    = $razorsedge::params::safe_enable_test,
  $reposerver     = $razorsedge::params::reposerver,
  $repopath       = $razorsedge::params::repopath,
  $priority       = $razorsedge::params::yum_priority,
  $protect        = $razorsedge::params::yum_protect,
  $proxy          = $razorsedge::params::proxy,
  $proxy_username = $razorsedge::params::proxy_username,
  $proxy_password = $razorsedge::params::proxy_password
) inherits razorsedge::params {
  validate_bool($enable_test)

  case $ensure {
    /(present)|(latest)/: {
      $enabled_re = '1'
      $file_ensure = 'present'
    }
    /(absent)/: {
      $enabled_re = '0'
      $file_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }
  if $enable_test {
    $enabled_re_test = '1'
  } else {
    $enabled_re_test = '0'
  }

  yumrepo { 'RE':
    descr          => 'RazorsEdge RPM Repository',
    enabled        => $enabled_re,
    gpgcheck       => '1',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
    baseurl        => "${reposerver}${repopath}/RE/",
    priority       => $priority,
    protect        => $protect,
    proxy          => $proxy,
    proxy_username => $proxy_username,
    proxy_password => $proxy_password,
  }

  yumrepo { 'RE-test':
    descr          => 'RazorsEdge Test RPM Repository',
    enabled        => $enabled_re_test,
    gpgcheck       => '1',
    gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
    baseurl        => "${reposerver}${repopath}/RE-test/",
    priority       => $priority,
    protect        => $protect,
    proxy          => $proxy,
    proxy_username => $proxy_username,
    proxy_password => $proxy_password,
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge':
    ensure => $file_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/razorsedge/RPM-GPG-KEY-razorsedge',
  }

  file { '/etc/yum.repos.d/RE.repo':
    ensure => $file_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { '/etc/yum.repos.d/RE-test.repo':
    ensure => $file_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  gpg_key { 'RE':
    path   => '/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
    before => [ Yumrepo['RE'], Yumrepo['RE-test'], ],
  }
}
