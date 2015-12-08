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
  if $version =~ /^(\d+\.\d+).+/ {
    $release = $1
  } else {
    fail('$version is not properly formatted')
  }

  $base_url = "http://download.gna.org/wkhtmltopdf/${release}"
  $filename = "wkhtmltox-${version}_linux-${::lsbdistcodename}-${::architecture}.deb"
  $dependencies = ['fontconfig', 'libfontconfig1', 'libjpeg8', 'libxrender1', 'xfonts-base', 'xfonts-75dpi']

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
      provider => 'dpkg'
    }
  )

  ensure_packages($dependencies,
    {
      before => Package['wkhtmltox']
    }
  )
}
