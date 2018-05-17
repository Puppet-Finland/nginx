# nginx

A Puppet module for managing nginx servers. Includes optional firewall and monit 
support.

# Module usage

Setup nginx from distribution's repositories and purge the default config file:

    class { '::nginx':
      use_nginx_repo       => false,
      purge_default_config => true,
    }

Setup SSL certificates for nginx (requires [puppetfinland/sslcert](https://github.com/Puppet-Finland/puppet-sslcert)):

    include ::sslcert
    
    sslcert::set { 'example.org':
      ensure       => 'present',
      bundlefile   => 'DigiCertCA.crt',
      embed_bundle => true,
    }

Setup a HTTP virtualhost:

    nginx::http_server { 'http-virtualhost':
      ensure        => 'present',
      basic_auth    => false,
      document_root => '/var/www/html',
      autoindex     => 'on',
      ssl           => false,
    }

Setup a HTTPS virtualhost:

    nginx::http_server { "https-virtualhost":
      ensure        => 'present',
      certname      => 'example.org',
      ensure        => 'present',
      basic_auth    => false,
      document_root => '/var/www/html',
      autoindex     => 'on',
      ssl           => true,
    }

For details see [init.pp](manifests/init.pp) and [http_server.pp](manifests/http_server.pp).
