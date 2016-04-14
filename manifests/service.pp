# == Class: nfsen::service
#
# Ensures the nfsen service is running
#
class nfsen::service {

  assert_private()
    
  file { '/etc/systemd/system/nfsen.service':
    ensure    => 'file',
    content   => templte('nfsen/nfsen.service.erb'),
  }
  service { 'nfsen':
    ensure    => 'running',
    hasstatus => false,
    path      => "${::nfsen::basedir}/bin",
    pattern   => "${::nfsen::basedir}/bin/nfsend"
  }

}
