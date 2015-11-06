require 'spec_helper'
describe 'backuprunner' do

  context 'with defaults for all parameters' do
    it { should contain_class('backuprunner') }
  end
end
