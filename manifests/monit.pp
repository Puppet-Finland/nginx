#
# == Class: nginx::monit
#
# Add local monitoring for nginx processes
#
class nginx::monit inherits nginx::params {

    monit::fragment { 'nginx.monit':
        basename   => 'nginx',
        modulename => 'nginx',
    }
}
