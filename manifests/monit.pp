#
# == Class: nginx::monit
#
# Add local monitoring for nginx processes
#
class nginx::monit {

    include nginx::params

    monit::fragment { 'nginx.monit':
        modulename => 'nginx',
    }
}
