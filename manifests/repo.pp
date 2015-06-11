#
# == Class: nginx::repo
#
# Configure official nginx software repositories.
#
# Currently only Debian/Ubuntu is supported, but adding RedHat support would be
# fairly straightforward.
#
class nginx::repo
(
    $use_nginx_repo

) inherits nginx::params
{
    if $use_nginx_repo {
        if $::osfamily == 'Debian' {
            include ::nginx::repo::debian
        } else {
            fail("Parameter \$use_nginx_repos only supports Debian/Ubuntu currently")
        }
    }
}
