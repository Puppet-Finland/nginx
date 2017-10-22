#
# == Class: nginx
#
# Install and configure nginx. Note that packet filtering configuration and some 
# other things are handled by the 'webserver' module.
#
# == Parameters
#
# [*manage*]
#   Manage nginx using Puppet. Valid values are true (default) and false.
# [*manage_config*]
#   Manage nginx configuration. Valid values are true (default) 
#   and false.
# [*manage_packetfilter*]
#   Manage packet filtering rules. Valid values are true (default) and false.
# [*manage_monit*]
#   Manage monit rules. Valid values are true (default) and false.
# [*purge_default_config*]
#   Whether to purge the default configuration file or not. Valid values are 
#   true and false (default). The default server directive (virtual host in 
#   Apache speak) is typically pretty useless, pointing to nginx documentation 
#   under /usr/share/doc or similar. Unless you manage nginx configuration 
#   manually or in a separate Puppet module, it's probably best to set this 
#   parameter to true.
# [*use_nginx_repo*]
#   Whether to use official nginx software repositories. Valid values are true 
#   and false (default). If this is set to false then nginx is fetched from the 
#   operating system's own software repositories.
# [*http_servers*]
#   A hash of ::nginx::http_server resources to realize. Leave empty to not 
#   create any HTTP server configurations in nginx.
# [*allow_address_ipv4*]
#   IPv4 addresses/networks from which to allow connections. This parameter can 
#   be either a string or an array. Defaults to 'anyv4' which means that access 
#   is allowed from any IPv4 address. Uses the webserver module to do the hard 
#   lifting.
# [*allow_address_ipv6*]
#   As above but for IPv6 addresses. Defaults to 'anyv6', thus allowing access 
#   from any IPv6 address. Uses the webserver module to do the hard lifting.
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
    Boolean $manage = true,
    Boolean $manage_config = true,
    Boolean $manage_packetfilter = true,
    Boolean $manage_monit = true,
            $purge_default_config = false,
            $use_nginx_repo = false,
            $allow_address_ipv4 = 'anyv4',
            $allow_address_ipv6 = 'anyv6',
    Hash    $http_servers = {},
)
{

if $manage {

    class { '::nginx::repo':
        use_nginx_repo => $use_nginx_repo,
    }

    include ::nginx::install

    if $manage_config {
        class { '::nginx::config':
            purge_default_config => $purge_default_config,
            http_servers         => $http_servers,
        }

        # Create the htpasswd file, if one or more credentials have been defined
        File <| tag == 'htpasswd' |>

    }

    include ::nginx::service

    if $manage_packetfilter {
        class { '::webserver::packetfilter':
            allow_address_ipv4 => $allow_address_ipv4,
            allow_address_ipv6 => $allow_address_ipv6,
        }
    }

    if $manage_monit {
        include ::nginx::monit
    }
}
}
