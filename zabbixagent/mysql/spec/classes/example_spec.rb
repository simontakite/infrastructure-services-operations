require 'spec_helper'

describe 'mysql' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "mysql class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('mysql::params') }
          it { is_expected.to contain_class('mysql::install').that_comes_before('mysql::config') }
          it { is_expected.to contain_class('mysql::config') }
          it { is_expected.to contain_class('mysql::service').that_subscribes_to('mysql::config') }

          it { is_expected.to contain_service('mysql') }
          it { is_expected.to contain_package('mysql-server').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'mysql class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('mysql') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
