#
# == Class: nginx
#
# Install and configure nginx. Note that packet filtering configuration and some 
# other things are handled by the 'webserver' module.
#
# == Parameters
#
# None at the moment
#
# == Examples
#
# include webserver
# include nginx
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
# Samuli Seppänen <samuli@openvpn.net>
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class nginx {

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_nginx', 'true') != 'false' {

    include nginx::install
    include nginx::config
    include nginx::service

    if tagged(monit) {
        include nginx::monit
    }
}
}
