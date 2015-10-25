require 'spec_helper'

describe 'zabbixagent' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "zabbixagent class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('zabbixagent::params') }
          it { is_expected.to contain_class('zabbixagent::install').that_comes_before('zabbixagent::config') }
          it { is_expected.to contain_class('zabbixagent::config') }
          it { is_expected.to contain_class('zabbixagent::service').that_subscribes_to('zabbixagent::config') }

          it { is_expected.to contain_service('zabbix-agent') }
          it { is_expected.to contain_package('zabbix-agent').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'zabbixagent class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('zabbixagent') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
