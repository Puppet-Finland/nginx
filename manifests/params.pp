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
            $service_name = 'nginx'
            $pidfile = '/var/run/nginx.pid'
        }
        'Debian': {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $pidfile = '/var/run/nginx.pid'
        }
        'FreeBSD': {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $pidfile = '/var/run/nginx.pid'
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
