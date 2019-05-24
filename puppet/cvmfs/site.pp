node default {
  include profile::base
  include profile::freeipa::client
  include profile::nfs::client
  include profile::cvmfs::client
  include profile::rsyslog::client
}

node /^login\d+$/ {
  include profile::base
  include profile::freeipa::client
  include profile::nfs::client
  include profile::cvmfs::client
  include profile::rsyslog::client
  include profile::slurm::submitter
  include profile::singularity
  include profile::fail2ban
}

node /^mgmt01$/ {
  include profile::slurm::controller
  include profile::slurm::accounting
  include profile::nfs::server
  include profile::freeipa::server

  include profile::base
  include profile::freeipa::guest_accounts
  include profile::rsyslog::server
  include profile::squid::server
}

node /^node\d+$/ {
  include profile::base
  include profile::freeipa::client
  include profile::nfs::client
  include profile::rsyslog::client
  include profile::cvmfs::client
  include profile::gpu
  include profile::slurm::node
  include profile::singularity

  Class['profile::freeipa::client'] -> Class['profile::nfs::client'] -> Class['profile::slurm::node']
}