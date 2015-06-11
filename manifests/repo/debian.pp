#
# == Class: nginx::repo::debian
#
# Setup official nginx repos on Debian/Ubuntu
#
# Note that this class depends on the "puppetlabs/apt" puppet module:
#
# <https://forge.puppetlabs.com/puppetlabs/apt>
#
class nginx::repo::debian inherits nginx::params {

    include ::apt

    apt::source { 'nginx-aptrepo':
        ensure   => 'present',
        location => $::nginx::params::apt_repo_location,
        release  => $::nginx::params::apt_repo_release,
        repos    => $::nginx::params::apt_repo_repos,
        key      => {
            'id'     => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62',
            'source' => 'http://nginx.org/keys/nginx_signing.key',
        },
    }
}
