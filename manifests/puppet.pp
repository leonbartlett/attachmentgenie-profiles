# This class can be used install puppet components.
#
# @example when declaring the puppet class
#  class { '::profiles::puppet': }
#
# @param foreman       Manage foreman on this node.
# @param foreman_proxy Manage foreman_proxy on this node.
# @param puppetdb      Manage puppetdb on this node.
# @param puppetmaster  Manage puppetmaster on this node.
# @param r10k          Manage r10k on this node.
class profiles::puppet (
  $foreman = false,
  $foreman_proxy = false,
  $puppetdb = false,
  $puppetmaster = false,
  $r10k = false,
) {
  if $foreman {
    class { '::profiles::puppet::foreman': }
    if $foreman and $foreman_proxy {
      Class['::foreman']
      -> Class['::foreman_proxy::register']
    }
  }
  if $puppetdb {
    class { '::profiles::puppet::puppetdb': }
  }
  if $puppetmaster and $foreman_proxy {
    class { '::profiles::puppet::foreman_proxy': }
  }
  if $r10k {
    class { '::profiles::puppet::r10k': }
  }

}
