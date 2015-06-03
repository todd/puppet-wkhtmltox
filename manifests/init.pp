# == Class: wkhtmltox
#
# Installs wkhtmltopdf and wkhtmltoimage. 
#
# === Parameters
#
# [*version*]
#   Specifies the version of wkhtmltox to install.
#
# === Examples
#
#  include wkhtmltox
#
# Or:
#
#  class { wkhtmltox:
#    version => '0.12.2.1',
#  }
#
# === Authors
#
# Todd Bealmear <todd@t0dd.io>
#
# === Copyright
#
# Copyright 2015 Todd Bealmear, unless otherwise noted.
#
class wkhtmltox ( $version = '0.12.2.1' ) {
  $base_url = 'http://downloads.sourceforge.net/project/wkhtmltopdf'
  $filename = "wkhtmltox-${version}_linux-${::lsbdistcodename}-${::architecture}.deb"

  exec { 'get_deb':
    cwd     => '/tmp',
    command => "/usr/bin/wget ${base_url}/${version}/${filename}",
    creates => "/tmp/${filename}",
    unless  => "/usr/bin/test ${version} = $(/usr/bin/dpkg-query -W -f='\${Version}' wkhtmltox)"
  }

  ensure_packages('wkhtmltox',
    {
      ensure   => present,
      source   => "/tmp/${filename}",
      provider => 'dpkg',
      require  => Exec['install_deps']
    }
  )

  exec { 'install_deps':
    command => '/usr/bin/apt-get update && /usr/bin/apt-get -y -f install fontconfig libfontconfig1 libjpeg8 libxrender1 xfonts-base xfonts-75dpi',
    require => Exec['get_deb']
  }
}
