require 'spec_helper'

describe 'memcached' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "memcached class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('memcached::params') }
          it { is_expected.to contain_class('memcached::install').that_comes_before('memcached::config') }
          it { is_expected.to contain_class('memcached::config') }
          it { is_expected.to contain_class('memcached::service').that_subscribes_to('memcached::config') }

          it { is_expected.to contain_service('memcached') }
          it { is_expected.to contain_package('memcached').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'memcached class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('memcached') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
