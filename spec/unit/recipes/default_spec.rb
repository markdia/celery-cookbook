require 'spec_helper'

describe 'celery::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'creates the workdir directory' do
    expect(chef_run).to create_directory('/var/celery')
  end

  it 'creates the config file' do
    expect(chef_run).to create_file('/var/celery/config.json')
  end

  %w(python supervisor).each do |recipe|
    it "includes recipe #{recipe}" do
      expect(chef_run).to include_recipe(recipe)
    end
  end

end
