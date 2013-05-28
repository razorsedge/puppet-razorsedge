name    'razorsedge-razorsedge'
version '1.0.0'

author 'razorsedge'
license 'Apache License, Version 2.0'
project_page 'https://github.com/razorsedge/puppet-razorsedge'
source 'git://github.com/razorsedge/puppet-razorsedge.git'
summary 'Install the RazorsEdge YUM Repository'
description 'This module mimics the razorsedge-release RPM. The same repos are enabled/disabled and the GPG key is imported. In the end you will end up with the RazorsEdge repos configured.'
dependency 'stahnma/epel', '>=0.0.3'

# Generate the changelog file
system("git-log-to-changelog > CHANGELOG")
$? == 0 or fail "changelog generation #{$?}!"
