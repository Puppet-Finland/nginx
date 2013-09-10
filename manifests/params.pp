#
# == Class: nginx::params
#
# Defines some variables based on the operating system
#
class nginx::params {

    case $::osfamily {
        'RedHat': {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $service_command = "/sbin/service $service_name"            
            $pidfile = '/var/run/nginx.pid'
            $admingroup = 'root'
        }
        'Debian': {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $service_command = "/usr/sbin/service $service_name" 
            $pidfile = '/var/run/nginx.pid'
            $admingroup = 'root'
        }
        'FreeBSD': {
            $package_name = 'nginx'            
            $service_name = 'nginx'
            $service_command = "/usr/local/etc/rc.d/$service_name" 
            $pidfile = '/var/run/nginx.pid'
            $admingroup = 'wheel'
        }
        default: {
            $package_name = 'nginx'
            $service_name = 'nginx'
            $service_command = "/usr/sbin/service $service_name" 
            $pidfile = '/var/run/nginx.pid'
            $admingroup = 'root'
        }
    }
}
