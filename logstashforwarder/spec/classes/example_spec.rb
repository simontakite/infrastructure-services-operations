require 'spec_helper'

describe 'logstashforwarder' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "logstashforwarder class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('logstashforwarder::params') }
          it { is_expected.to contain_class('logstashforwarder::install').that_comes_before('logstashforwarder::config') }
          it { is_expected.to contain_class('logstashforwarder::config') }
          it { is_expected.to contain_class('logstashforwarder::service').that_subscribes_to('logstashforwarder::config') }

          it { is_expected.to contain_service('logstashforwarder') }
          it { is_expected.to contain_package('logstashforwarder').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'logstashforwarder class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('logstashforwarder') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
