class profiles::foreman (
  $apipie_task            = 'apipie:cache:index',
  $configure_epel_repo    = false,
  $custom_repo            = false,
  $db_manage              = true,
  $foreman_admin_password = 'secret',
  $foreman_host           = $::fqdn,
  $foreman_repo           = 'stable',
  $locations_enabled      = false,
  $organizations_enabled  = false,
  $passenger              = true,
  $plugins                = {},
  $selinux                = false,
  $ssl                    = true,
  $server_ssl_ca          = '/var/lib/puppet/ssl/certs/ca.pem',
  $server_ssl_chain       = '/var/lib/puppet/ssl/certs/ca.pem',
  $server_ssl_cert        = "/var/lib/puppet/ssl/certs/${::fqdn}.pem",
  $server_ssl_key         = "/var/lib/puppet/ssl/private_keys/${::fqdn}.pem",
  $server_ssl_crl         = '/var/lib/puppet/ssl/ca/ca_crl.pem',
  $unattended             = true,
) {
  class { '::foreman':
    admin_password        => $foreman_admin_password,
    apipie_task           => $apipie_task,
    authentication        => true,
    configure_epel_repo   => $configure_epel_repo,
    custom_repo           => $custom_repo,
    db_manage             => $db_manage,
    foreman_url           => $foreman_host,
    locations_enabled     => $locations_enabled,
    organizations_enabled => $organizations_enabled,
    passenger             => $passenger,
    selinux               => $selinux,
    ssl                   => $ssl,
    server_ssl_ca         => $server_ssl_ca,
    server_ssl_chain      => $server_ssl_chain,
    server_ssl_cert       => $server_ssl_cert,
    server_ssl_key        => $server_ssl_key,
    server_ssl_crl        => $server_ssl_crl,
    repo                  => $foreman_repo,
    unattended            => $unattended,
  } ->
  class { '::foreman::cli':
    foreman_url => $foreman_host,
    username    => 'admin',
    password    => $foreman_admin_password,
  }
  create_resources(::foreman::plugin, $plugins)
}
