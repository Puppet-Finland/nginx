#
# == Define: nginx::basic_auth_user
#
# Setup a credentials for a basic auth user
#
define nginx::basic_auth_user
(
    $password
)
{
    include ::nginx::params

    $username = $title

    @file { '/etc/nginx/htpasswd':
        ensure => 'present',
        owner  => $::os::params::adminuser,
        group  => $::nginx::params::www_group,
        tag    => 'htpasswd',
    }

    file_line { $username:
        ensure => 'present',
        path   => '/etc/nginx/htpasswd',
        line   => "${username}:${password}",
    }
}
