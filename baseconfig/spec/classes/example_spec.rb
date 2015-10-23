require 'spec_helper'

describe 'baseconfig' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "baseconfig class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('baseconfig::params') }
          it { is_expected.to contain_class('baseconfig::install').that_comes_before('baseconfig::config') }
          it { is_expected.to contain_class('baseconfig::config') }
          it { is_expected.to contain_class('baseconfig::service').that_subscribes_to('baseconfig::config') }

#          it { is_expected.to contain_service('baseconfig') }
#          it { is_expected.to contain_package('baseconfig').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'baseconfig class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('baseconfig') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
