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
    $purge_default_config,
    $http_servers

) inherits nginx::params {

    validate_bool($purge_default_config)
    validate_hash($http_servers)

    if $purge_default_config {
        file { $::nginx::params::default_config:
            ensure  => absent,
            notify  => Class['nginx::service'],
            require => Class['nginx::install'],
        }
    }

    # Create HTTP server entries
    create_resources('nginx::http_server', $http_servers)
}
