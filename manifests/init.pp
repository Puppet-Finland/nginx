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
# [*use_nginx_repo*]
#   Whether to use official nginx software repositories. Valid values are true 
#   and false (default). If this is set to false then nginx is fetched from the 
#   operating system's own software repositories.
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
    $manage_config = 'yes',
    $use_nginx_repo = false
)
{

if $manage == 'yes' {

    class { '::nginx::repo':
        use_nginx_repo => $use_nginx_repo,
    }

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
