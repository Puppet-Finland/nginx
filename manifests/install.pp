#
# == Class: nginx::install
#
# Install nginx
#
class nginx::install inherits nginx::params {

    package { 'nginx-nginx':
        ensure => installed,
        name   => $::nginx::params::package_name,
    }
}
