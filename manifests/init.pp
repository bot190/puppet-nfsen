# == Class: nfsen
#
# This class installs/configures/manages nfsen.
#
# === Parameters
#
# [*use_ramdisk*]
#   Boolean. Mounts a ramdisk, uses the $profiledatadir for the 
#   base of the RAM disk. $profiledatadir must not be left default
#   and the directory must exist already (Puppet parent limitation).
#
# [*ramdisk_size*]
#   String. The size of the RAM disk if $use_ramdisk is true.
#
# [*basedir*]
#   String. Base directory for nfsen.
#
# [*bindir*]
#   String. Default '${BASEDIR}/bin'
#
# [*libexecdir*]
#   String. Default '${BASEDIR}/libexec'
#
# [*confdir*]
#   String. Default '${BASEDIR}/etc'
#
# [*htmldir*]
#   String. Default '/var/www/nfsen'
#
# [*docdir*]
#   String. Default '${BASEDIR}/doc'
#
# [*vardir*]
#   String. Default '${BASEDIR}/var'
#
# [*piddir*]
#   String. Default '${BASEDIR}/run'
#
# [*filterdir*]
#   String. Default '${BASEDIR}/filters'
#
# [*formatdir*]
#   String. Default '${BASEDIR}/fmt',
#
# [*profilestatdir*]
#   String. Default '${BASEDIR}/profiles-stat',
#
# [*profiledatadir*]
#   String. Default "#{BASEDIR}/profiles-data',
#
# [*backend_plugindir*]
#   String. Default "#{BASEDIR}/plugins',
#
# [*frontend_plugindir*]
#   String. Default "#{HTMLDIR}/plugins',
#
# [*prefix*]
#   String. Default '/usr/bin',
#
# [*commsocket*]
#   String. Default '${PIDDIR}/nfsen.comm',
#
# [*user*]
#   String. Default 'netflow',
#
# [*wwwuser*]
#   String. Default 'www-data'
#
# [*wwwgroup*]
#   String. Default 'www-group'
#
# [*bufflen*]
#   Integer. Default 200000 (bytes)
#
# [*extensions*]
#   String. Default 'all'
#
# [*subdirlayout*]
#   Integer. Default 2 (see nfdump/nfsen doc)
#
# [*zipcollected*]
#   Boolean. Default true
#
# [*zipprofiles*]
#   Boolean. Default true
#
# [*profilers*]
#   Integer. Default 2
#
# [*disklimit*]
#   Integer. Default 98
#
# [*low_water*]
#   Integer. Default 90
#
# [*syslog_facility*]
#   String. Default 'local3'
#
# [*mail_from*]
#   String. Default 'your@from.example.net'
#
# [*mail_body*]
#   String. Default 'q{ Alert \'@alert@\' triggered at timeslot @timeslot@ };'
#
# [*sources*]
#   Array of Hashes. See examples.
#
# [*web*]
#   Boolean.  Whether to install the secure web frontend
#
# [*web_ssl_verify_client*]
#   String. Apache2 compatible client verify string e.g. none, required
#
# [*web_ssl_verify_depth*]
#   Integer.  Number of (intermediate) CA certificates to verify
#
class nfsen (
  $use_ramdisk = false,
  $ramdisk_size = '0M',
  $basedir = '/var/lib/nfsen',
  $bindir = '${BASEDIR}/bin',
  $libexecdir = '${BASEDIR}/libexec',
  $confdir = '${BASEDIR}/etc',
  $htmldir = '/var/www/html/nfsen/',
  $docdir = '${BASEDIR}/doc',
  $vardir = '${BASEDIR}/var',
  $piddir = '${BASEDIR}/run',
  $filterdir = '${VARDIR}/filters',
  $formatdir = '${VARDIR}/fmt',
  $profilestatdir = '${BASEDIR}/profiles-stat',
  $profiledatadir = '${BASEDIR}/profiles-data',
  $backend_plugindir = '${BASEDIR}/plugins',
  $frontend_plugindir = '${HTMLDIR}/plugins',
  $prefix = '/usr/bin',
  $commsocket = '${PIDDIR}/nfsen.comm',
  $user = 'netflow',
  $wwwuser = 'www-data',
  $wwwgroup = 'www-data',
  $bufflen = 200000,
  $extensions = 'all',
  $subdirlayout = 1,
  $zipcollected = true,
  $zipprofiles = true,
  $profilers = 2,
  $disklimit = 98,
  $low_water = 90,
  $syslog_facility = 'local3',
  $mail_from = "netflow@${::fqdn}",
  $smtp_server = 'localhost',
  $mail_body = 'q{ Alert \'@alert@\' triggered at timeslot @timeslot@ };',
  $sources = [
    {
      name => 'all',
      port => '9995',
      col  => '#0000ff',
      type => 'netflow',
    },
  ],
  $web = true,
  $web_ssl_verify_client = 'none',
  $web_ssl_verify_depth = 1,
) {

  include ::nfsen::install
  include ::nfsen::configure
  include ::nfsen::service
  include ::nfsen::web

  Class['::nfsen::install'] ->
  Class['::nfsen::configure'] ~>
  Class['::nfsen::service'] ->
  Class['::nfsen::web']

}
