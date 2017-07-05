#
# == Define: nginx::http_server
#
# Create a HTTP-based nginx server (virtual host) configuration
#
# == Parameters
#
# [*server_name*]
#   This parameter is used as the basename of configuration file, for the
#   server_name directive and as a basename for the nginx log file. Defaults to
#   resource $title.
# [*ensure*]
#   Status of this resource. Valid values are 'present' (default) and 'absent'.
# [*ssl*]
#   Whether this server uses SSL. Defaults to false.
# [*listen_port*]
#   The port on which this nginx server (virtual host) instance listens on. 
#   Should be an integer. Defaults to 80 or 443 depending on value of the
#   $ssl parameter.
# [*document_root*]
#   The document root on the filesystem for this server. Defaults to '/var/www'.
# [*autoindex*]
#   The value of autoindex parameter for the documentroot. Valid values are 'on' 
#   and 'off' (default).
# [*certname*]
#   The basename of the SSL key and certificate file. If undefined, defaults to
#   $server_name.
# [*basic_auth*]
#   Whether to use a htpasswd-based credentials file. Valid values are true and
#   false (default).
#
define nginx::http_server
(
    Enum['present','absent'] $ensure = 'present',
    Boolean                  $ssl = false,
    Boolean                  $basic_auth = false,
    String                   $document_root = '/var/www',
    Enum['on','off']         $autoindex = 'off',
    Optional[String]         $server_name = undef,
    Optional[Integer]        $listen_port = undef,
    Optional[String]         $certname = undef,
)
{
    include ::nginx::params

    # Set some reasonable default values
    $l_server_name = $server_name ? {
        undef   => $title,
        default => $server_name,
    }

    $l_certname = $certname ? {
        undef   => $l_server_name,
        default => $certname,
    }

    if $listen_port {
        $port = $listen_port
    } else {
        $port = $ssl ? {
            true  => 443,
            false => 80,
        }
    }

    $ipv4_listen_base = "listen 0.0.0.0:${port} default_server"
    $ipv6_listen_base = "listen [::]:${port} default_server ipv6only=on"

    if $ssl {
        $ipv4_listen = "${ipv4_listen_base} ssl"
        $ipv6_listen = "${ipv6_listen_base} ssl"
    } else {
        $ipv4_listen = $ipv4_listen_base
        $ipv6_listen = $ipv6_listen_base
    }

    File {
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        require => Class['nginx::install'],
    }

    file { "nginx-http_server-${l_server_name}":
        ensure  => $ensure,
        name    => "${::nginx::params::conf_d_dir}/${l_server_name}.conf",
        content => template('nginx/http_server.conf.erb'),
        mode    => '0644',
        notify  => Class['nginx::service'],
    }
}
