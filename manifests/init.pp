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
  $priority       = $razorsedge::params::yum_priority,
  $protect        = $razorsedge::params::yum_protect,
  $proxy          = $razorsedge::params::proxy,
  $proxy_username = $razorsedge::params::proxy_username,
  $proxy_password = $razorsedge::params::proxy_password
) inherits razorsedge::params {
  case $ensure {
    /(present)/: {
      $enabled = '1'
      $file_ensure = 'present'
    }
    /(absent)/: {
      $enabled = '0'
      $file_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  if $::osfamily == 'RedHat' and $::operatingsystem != 'Fedora' {
    yumrepo { 'RE':
      descr          => 'RazorsEdge RPM Repository',
      enabled        => $enabled,
      gpgcheck       => '1',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      baseurl        => "http://rpm.razorsedge.org/el-${::os_maj_version}/RE/",
      priority       => $priority,
      protect        => $protect,
      proxy          => $proxy,
      proxy_username => $proxy_username,
      proxy_password => $proxy_password,
    }

    yumrepo { 'RE-test':
      descr          => 'RazorsEdge Test RPM Repository',
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      baseurl        => "http://rpm.razorsedge.org/el-${::os_maj_version}/RE-test/",
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
  } elsif $::osfamily == 'RedHat' and $::operatingsystem == 'Fedora' {
    yumrepo { 'RE':
      descr          => 'RazorsEdge RPM Repository',
      enabled        => $enabled,
      gpgcheck       => '1',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      baseurl        => "http://rpm.razorsedge.org/fedora-${::operatingsystemrelease}/RE/",
      priority       => $priority,
      protect        => $protect,
      proxy          => $proxy,
      proxy_username => $proxy_username,
      proxy_password => $proxy_password,
    }

    yumrepo { 'RE-test':
      descr          => 'RazorsEdge Test RPM Repository',
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      baseurl        => "http://rpm.razorsedge.org/fedora-${::operatingsystemrelease}/RE-test/",
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
  } else {
      notice("Your operating system ${::operatingsystem} will not have the RazorsEdge repository applied.")
  }

}
