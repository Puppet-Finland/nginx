#
# == Class: nginx::config
#
# Configure nginx
#
# Any virtualhost-specific configurations should be done in a (currently 
# non-existing) define.
#
class nginx::config
(
    Boolean $purge_default_config,
    Hash    $http_servers,

) inherits nginx::params {

    if $purge_default_config {
        file { $::nginx::params::default_config:
            ensure  => absent,
            notify  => Class['nginx::service'],
            require => Class['nginx::install'],
        }
    }

    # Create server entries
    create_resources('nginx::http_server', $http_servers)
}
