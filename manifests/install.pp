#
# == Class: nginx::install
#
# Install nginx
#
class nginx::install {

    include nginx::params

    package { 'nginx-nginx':
        name => "${::nginx::params::package_name}",
        ensure => installed,
    }
}
