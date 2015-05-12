#
# == Class: nginx
#
# Install and configure nginx. Note that packet filtering configuration and some 
# other things are handled by the 'webserver' module.
#
# == Parameters
#
# [*manage*]
#   Manage nginx using Puppet. Valid values are 'yes' (default) and 'no'.
# [*manage_config*]
#   Manage nginx configuration using Puppet. Valid values are 'yes' (default) 
#   and 'no'.
#
# == Examples
#
#   include webserver
#   include nginx
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# Samuli Seppänen <samuli@openvpn.net>
#
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class nginx
(
    $manage = 'yes',
    $manage_config = 'yes'
)
{

if $manage == 'yes' {

    include ::nginx::install

    if $manage_config == 'yes' {
        include ::nginx::config
    }

    include ::nginx::service

    if tagged(monit) {
        include ::nginx::monit
    }
}
}
