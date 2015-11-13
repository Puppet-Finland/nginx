#
# == Define: nginx::http_server
#
# Create a HTTP-based nginx server (virtual host) configuration
#
# == Parameters
#
# [*server_name*]
#   This parameter is used as the basename of configuration file, for the 
#   server_name directive and as a basename for the nginx log file.
# [*ensure*]
#   Status of this resource. Valid values are 'present' (default) and 'absent'.
# [*listen_port*]
#   The port on which this nginx server (virtual host) instance listens on. 
#   Should be an integer. Defaults to 80.
# [*document_root*]
#   The document root on the filesystem for this server. Defaults to '/var/www'.
# [*autoindex*]
#   The value of autoindex parameter for the documentroot. Valid values are 'on' 
#   and 'off' (default).
#
define nginx::http_server
(
    $server_name,
    $ensure = 'present',
    $listen_port = 80,
    $document_root = '/var/www',
    $autoindex = 'off'
)
{

    validate_string($server_name)
    validate_re($ensure, [ '^present$', '^absent$' ])
    validate_numeric($listen_port)
    validate_string($document_root)
    validate_re($autoindex, [ '^on$', '^off$' ])

    include ::nginx::params

    File {
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        require => Class['nginx::install'],
    }

    # You must ensure that the parent directory exists
    file { $document_root:
        ensure => directory,
        mode   => '0755',
    }

    file { "nginx-http_server-${server_name}":
        ensure  => $ensure,
        name    => "${::nginx::params::conf_d_dir}/${server_name}.conf",
        content => template('nginx/http_server.conf.erb'),
        mode    => '0644',
        notify  => Class['nginx::service'],
    }
}
