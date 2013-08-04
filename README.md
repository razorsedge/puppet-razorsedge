Puppet RazorsEdge YUM Repository Module
=======================================

master branch: [![Build Status](https://secure.travis-ci.org/razorsedge/puppet-razorsedge.png?branch=master)](http://travis-ci.org/razorsedge/puppet-razorsedge)
develop branch: [![Build Status](https://secure.travis-ci.org/razorsedge/puppet-razorsedge.png?branch=develop)](http://travis-ci.org/razorsedge/puppet-razorsedge)

Introduction
------------

This module mimics the razorsedge-release RPM from the [Razor's Edge RPM Repository](http://rpm.razorsedge.org/). The same repos are enabled/disabled and the GPG key is imported. In the end you will end up with the RazorsEdge repos configured. The work is heavily modeled on (read: stolen from) Mike Stahnke’s EPEL module.

Actions:

* The following Repos will be installed and enabled by default:
  * RE
* Other repositories that will installed but disabled (as per the razorsedge-release setup):
  * RE-testing

OS Support:

* RedHat family - tested on Fedora 16, CentOS 5.9, and CentOS 6.3

Class documentation is available via puppetdoc.

Examples
--------

Simple usage:

    include 'razorsedge'

Customized usage:

    class { 'razorsedge':
      ensure         => 'present',
      priority       => '50',
      protect        => '0',
      proxy          => 'absent',
      proxy_username => 'absent',
      proxy_password => 'absent',
    }


Notes
-----

* Supports Top Scope variables (i.e. via Dashboard) and Parameterized Classes.

Issues
------

* None

TODO
----

* None

Contributing
------------

Please see DEVELOP.md for contribution information.

License
-------

Please see LICENSE file.

Copyright
---------

Copyright (C) 2013 Mike Arnold <mike@razorsedge.org>

[razorsedge/puppet-razorsedge on GitHub](https://github.com/razorsedge/puppet-razorsedge)

[razorsedge/razorsedge on Puppet Forge](http://forge.puppetlabs.com/razorsedge/razorsedge)

