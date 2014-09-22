#!/usr/bin/env rspec

require 'spec_helper'

describe 'razorsedge', :type => 'class' do

  context 'on a non-supported operatingsystem' do
    let :facts do {
      :osfamily        => 'foo',
      :operatingsystem => 'bar'
    }
    end
    #it { should contain_notice('Your operating system bar will not have the RazorsEdge repository applied.') }
    it 'should not fail' do
      expect {
        should_not raise_error(Puppet::Error)
      }
    end
  end

  context 'on a supported operatingsystem, not Fedora, default parameters' do
    let(:params) {{}}
    let :facts do {
      :osfamily        => 'RedHat',
      :operatingsystem => 'CentOS',
      :os_maj_version  => '6'
    }
    end
    it { should contain_yumrepo('RE').with(
      :descr          => 'RazorsEdge RPM Repository',
      :enabled        => '1',
      :gpgcheck       => '1',
      :gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      :baseurl        => 'http://rpm.razorsedge.org/el-6/RE/',
      :priority       => '50',
      :protect        => '0',
      :proxy          => 'absent',
      :proxy_username => 'absent',
      :proxy_password => 'absent'
    )}
    it { should contain_yumrepo('RE-test').with(
      :descr          => 'RazorsEdge Test RPM Repository',
      :enabled        => '0',
      :gpgcheck       => '1',
      :gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      :baseurl        => 'http://rpm.razorsedge.org/el-6/RE-test/',
      :priority       => '50',
      :protect        => '0',
      :proxy          => 'absent',
      :proxy_username => 'absent',
      :proxy_password => 'absent'
    )}
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge').with(
      :ensure => 'present',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644',
      :source => 'puppet:///modules/razorsedge/RPM-GPG-KEY-razorsedge'
    )}
    it { should contain_gpg_key('RE').with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge') }
  end

  context 'on a supported operatingsystem, Fedora, default parameters' do
    let(:params) {{}}
    let :facts do {
      :osfamily               => 'RedHat',
      :operatingsystem        => 'Fedora',
      :operatingsystemrelease => '18'
    }
    end
    it { should contain_yumrepo('RE').with(
      :descr          => 'RazorsEdge RPM Repository',
      :enabled        => '1',
      :gpgcheck       => '1',
      :gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      :baseurl        => 'http://rpm.razorsedge.org/fedora-18/RE/',
      :priority       => '50',
      :protect        => '0',
      :proxy          => 'absent',
      :proxy_username => 'absent',
      :proxy_password => 'absent'
    )}
    it { should contain_yumrepo('RE-test').with(
      :descr          => 'RazorsEdge Test RPM Repository',
      :enabled        => '0',
      :gpgcheck       => '1',
      :gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge',
      :baseurl        => 'http://rpm.razorsedge.org/fedora-18/RE-test/',
      :priority       => '50',
      :protect        => '0',
      :proxy          => 'absent',
      :proxy_username => 'absent',
      :proxy_password => 'absent'
    )}
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge').with(
      :ensure => 'present',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644',
      :source => 'puppet:///modules/razorsedge/RPM-GPG-KEY-razorsedge'
    )}
    it { should contain_gpg_key('RE').with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge') }
  end

  context 'on a supported operatingsystem, custom parameters' do
    let :facts do {
      :osfamily        => 'RedHat',
      :operatingsystem => 'CentOS',
      :os_maj_version  => '6'
    }
    end

    describe 'ensure => absent' do
      let :params do {
        :ensure => 'absent'
      }
      end
      it { should contain_yumrepo('RE').with_enabled('0') }
      it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-razorsedge').with_ensure('absent') }
      it { should contain_file('/etc/yum.repos.d/RE.repo').with_ensure('absent') }
    end

    describe 'priority => 999' do
      let :params do {
        :priority => '999'
      }
      end
      it { should contain_yumrepo('RE').with(
        :enabled        => '1',
        :baseurl        => 'http://rpm.razorsedge.org/el-6/RE/',
        :priority       => '999',
        :protect        => '0',
        :proxy          => 'absent',
        :proxy_username => 'absent',
        :proxy_password => 'absent'
      )}
    end

    describe 'protect => 1' do
      let :params do {
        :protect => '1'
      }
      end
      it { should contain_yumrepo('RE').with(
        :enabled        => '1',
        :baseurl        => 'http://rpm.razorsedge.org/el-6/RE/',
        :priority       => '50',
        :protect        => '1',
        :proxy          => 'absent',
        :proxy_username => 'absent',
        :proxy_password => 'absent'
      )}
    end

    describe 'proxy => http://localhost/' do
      let :params do {
        :proxy => 'http://localhost/'
      }
      end
      it { should contain_yumrepo('RE').with(
        :enabled        => '1',
        :baseurl        => 'http://rpm.razorsedge.org/el-6/RE/',
        :priority       => '50',
        :protect        => '0',
        :proxy          => 'http://localhost/',
        :proxy_username => 'absent',
        :proxy_password => 'absent'
      )}
    end

    describe 'proxy_username => myUser' do
      let :params do {
        :proxy_username => 'myUser'
      }
      end
      it { should contain_yumrepo('RE').with(
        :enabled        => '1',
        :baseurl        => 'http://rpm.razorsedge.org/el-6/RE/',
        :priority       => '50',
        :protect        => '0',
        :proxy          => 'absent',
        :proxy_username => 'myUser',
        :proxy_password => 'absent'
      )}
    end

    describe 'proxy_password => myPassword' do
      let :params do {
        :proxy_password => 'myPassword'
      }
      end
      it { should contain_yumrepo('RE').with(
        :enabled        => '1',
        :baseurl        => 'http://rpm.razorsedge.org/el-6/RE/',
        :priority       => '50',
        :protect        => '0',
        :proxy          => 'absent',
        :proxy_username => 'absent',
        :proxy_password => 'myPassword'
      )}
    end

    describe 'enable_test => true' do
      let :params do {
        :enable_test => true
      }
      end
      it { should contain_yumrepo('RE').with_enabled('1') }
      it { should contain_yumrepo('RE-test').with_enabled('1') }
    end
  end

end
