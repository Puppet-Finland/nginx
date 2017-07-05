#
# == Class: nginx::params
#
# Defines some variables based on the operating system
#
class nginx::params {

    include ::os::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'nginx'
            $conf_d_dir = '/etc/nginx/conf.d'
            $default_config = "${conf_d_dir}/default.conf"
            $service_name = 'nginx'
            $pidfile = '/var/run/nginx.pid'
            $www_group = 'nginx'
        }
        'Debian': {
            $package_name = 'nginx'
            # While Debian also has /etc/nginx/sites-enabled, the conf.d 
            # directory is the standard nginx place to put configuration files 
            # to.
            $conf_d_dir = '/etc/nginx/conf.d'
            $default_config = '/etc/nginx/sites-enabled/default'
            $service_name = 'nginx'
            $pidfile = '/var/run/nginx.pid'
            $apt_repo_location = $::operatingsystem ? {
                'Ubuntu' => 'http://nginx.org/packages/ubuntu',
                'Debian' => 'http://nginx.org/packages/debian',
            }
            $apt_repo_release = $::lsbdistcodename
            $apt_repo_repos = 'nginx'
            $www_group = 'www-data'
        }
        'FreeBSD': {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $pidfile = '/var/run/nginx.pid'
            $www_group = 'www'
        }
        default: {
            fail("Unsupported operating system ${::osfamily}")
        }
    }

    if str2bool($::has_systemd) {
        $service_start = "${::os::params::systemctl} start ${service_name}"
        $service_stop = "${::os::params::systemctl} stop ${service_name}"
    } else {
        $service_start = "${::os::params::service_cmd} ${service_name} start"
        $service_stop = "${::os::params::service_cmd} ${service_name} stop"
    }
}
