# wkhtmltox
[![Build Status](https://travis-ci.org/todd/puppet-wkhtmltox.svg)](https://travis-ci.org/todd/puppet-wkhtmltox) 

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with wkhtmltox](#setup)
    * [What wkhtmltox affects](#what-wkhtmltox-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module installs wkhtmltopdf and wkhtmltoimage. This module currently only
supports Ubuntu 12.04 and 14.04 - Pull Requests are welcome for other platforms!

## Module Description

This module downloads and installs the wkhtmltox package and installs
wkhtmltopdf and wkhtmltoimage.

## Setup

### What wkhtmltox affects

* Installs wkhtmltopdf and wkhtmltoimage
* Installs the dependencies for the aformentioned packages:
  * fontconfig
  * libfontconfig1
  * libjpeg8
  * libxrender1
  * xfonts-base
  * xfonts-75dpi

### Setup Requirements

Requires wget.

## Usage

```puppet
include wkhtmltox
```

Or:

```puppet
class { 'wkhtmltox':
  version => '0.12.2.1'
}
```

## Limitations

Currently only supports Ubuntu Precise and Ubunty Trusty. Submit an issue or
Pull Request if there are additional platforms you'd like to see supported.
