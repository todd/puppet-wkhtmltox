require 'spec_helper'

RSpec.describe 'wkhtmltox' do
  let(:facts) do
    {
      lsbdistcodename: 'precise',
      architecture:    'i386'
    }
  end

  let(:filename) { "wkhtmltox-#{version}_linux-precise-i386.deb" }

  context 'with defaults for all parameters' do
    let(:version) { '0.12.2.1' }

    it { should contain_class('wkhtmltox') }

    it do
      should contain_exec('get_deb')
        .with(
          cwd: '/tmp',
          command: "/usr/bin/wget http://downloads.sourceforge.net/project/wkhtmltopdf/#{version}/#{filename}",
          creates: "/tmp/#{filename}",
          unless: '/usr/bin/dpkg -s wkhtmltopdf'
        )
    end

    it do
      should contain_package('install_wkhtmltox')
        .with(
          provider: 'dpkg',
          source:   "/tmp/#{filename}",
          ensure:   'installed',
          require:  'Exec[install_deps]'
        )
    end

    it do
      should contain_exec('install_deps')
        .with(
          command: '/usr/bin/apt-get update && /usr/bin/apt-get -y -f install fontconfig libfontconfig1 libjpeg8 libxrender1 xfonts-base xfonts-75dpi'
        )
    end
  end

  context 'with version => "0.12.2"' do
    let(:params)  { {version: '0.12.2'} }
    let(:version) { params[:version] }

    it do
      should contain_exec('get_deb')
        .with(
          cwd: '/tmp',
          command: "/usr/bin/wget http://downloads.sourceforge.net/project/wkhtmltopdf/#{version}/#{filename}",
          creates: "/tmp/#{filename}",
          unless: '/usr/bin/dpkg -s wkhtmltopdf'
        )
    end

    it do
      should contain_package('install_wkhtmltox')
        .with(
          provider: 'dpkg',
          source:   "/tmp/#{filename}",
          ensure:   'installed',
          require:  'Exec[install_deps]'
        )
    end
  end
end
