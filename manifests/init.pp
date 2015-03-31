# == Class: wkhtmltox
#
# Full description of class wkhtmltox here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { wkhtmltox:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class wkhtmltox ( $version = "0.12.2.1" ) {
  $base_url = "http://downloads.sourceforge.net/project/wkhtmltopdf"
  $filename = "wkhtmltox-${version}_linux-$lsbdistcodename-$architecture.deb"

  exec { "get_deb":
    cwd     => "/tmp",
    command => "/usr/bin/wget $base_url/$version/$filename",
    creates => "/tmp/$filename",
    unless  => "/usr/bin/dpkg -s wkhtmltopdf"
  }

  package { "install_wkhtmltox":
    provider => "dpkg",
    source   => "/tmp/$filename",
    ensure   => installed,
    require  => Exec["install_deps"]
  }

  exec { "install_deps":
    command => "/usr/bin/apt-get update && /usr/bin/apt-get -y -f install fontconfig libfontconfig1 libjpeg8 libxrender1 xfonts-base xfonts-75dpi"
  }
}
