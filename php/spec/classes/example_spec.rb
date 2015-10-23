require 'spec_helper'

describe 'php' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "php class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('php::params') }
          it { is_expected.to contain_class('php::install').that_comes_before('php::config') }
          it { is_expected.to contain_class('php::config') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'php class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('php') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
