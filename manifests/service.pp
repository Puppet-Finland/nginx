#
# == Class: nginx::service
#
# Enable the nginx service on boot
#
class nginx::service {

    include nginx::params

    service { 'nginx':
        name => "${::nginx::params::service_name}",
        enable => true,
        require => Class['nginx::install'],
    }
}
