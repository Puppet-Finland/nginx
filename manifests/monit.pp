#
# == Class: nginx::monit
#
# Add local monitoring for nginx processes
#
class nginx::monit {

    monit::fragment { 'nginx.monit':
        modulename => 'nginx',
    }
}
