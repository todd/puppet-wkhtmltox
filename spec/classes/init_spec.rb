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
          command: "/usr/bin/wget http://download.gna.org/wkhtmltopdf/0.12/#{version}/#{filename}",
          creates: "/tmp/#{filename}",
          unless: "/usr/bin/test #{version} = $(/usr/bin/dpkg-query -W -f='\${Version}' wkhtmltox)"
        )
    end

    it do
      should contain_package('wkhtmltox')
        .with(
          provider: 'dpkg',
          source:   "/tmp/#{filename}",
          ensure:   'present'
        )
    end

    it do
      should contain_package('fontconfig').with(
        before: "Package[wkhtmltox]"
      )
    end

    it do
      should contain_package('libfontconfig1').with(
        before: "Package[wkhtmltox]"
      )
    end

    it do
      should contain_package('libjpeg8').with(
        before: "Package[wkhtmltox]"
      )
    end

    it do
      should contain_package('libxrender1').with(
        before: "Package[wkhtmltox]"
      )
    end

    it do
      should contain_package('xfonts-base').with(
        before: "Package[wkhtmltox]"
      )
    end

    it do
      should contain_package('xfonts-75dpi').with(
        before: "Package[wkhtmltox]"
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
          command: "/usr/bin/wget http://download.gna.org/wkhtmltopdf/0.12/#{version}/#{filename}",
          creates: "/tmp/#{filename}",
          unless: "/usr/bin/test #{version} = $(/usr/bin/dpkg-query -W -f='\${Version}' wkhtmltox)"
        )
    end

    it do
      should contain_package('wkhtmltox')
        .with(
          provider: 'dpkg',
          source:   "/tmp/#{filename}",
          ensure:   'present'
        )
    end
  end
end
