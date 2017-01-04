# This class can be used install mysql
#
# @example when declaring the mysql class
#  class { '::profiles::mysql': }
#
# @param databases (Hash) Databases to create.
# @param root_password (String) root password.
class profiles::mysql (
  $databases     = {},
  $root_password = 'secret',
) {
  validate_hash(
    $databases,
  )
  validate_string(
    $root_password,
  )
  class { '::mysql::server':
    root_password => $root_password,
  }
  class { '::mysql::server::account_security': }
  create_resources(mysql::db, $databases)

  class { '::mysql::client': }
}