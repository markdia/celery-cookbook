include_recipe 'python'
include_recipe 'supervisor'
require 'json'

# Install python through pip
# Only pass version if specified
python_pip 'celery' do
  action :upgrade
  version node['celery']['version'] if node['celery']['version']
end

# Create celery's working directory
directory node['celery']['workdir'] do
  owner node['celery']['user']
  group node['celery']['group']
  mode '0755'
  action :create
end

# Pull in config from Chef
file "#{node['celery']['workdir']}/config.json" do
  owner node['celery']['user']
  group node['celery']['group']
  content node['celery']['config'].to_json
  mode '0666'
  action :create
  # only pull this file in if it exists, otherwise just keep humming along
  ignore_failure true
end

# Setup task file
if node['celery']['taskfile'] && !node['celery']['taskfile'].empty?
  remote_file "#{node['celery']['workdir']}/#{node['celery']['app']}.py" do
    source node['celery']['taskfile']
    owner node['celery']['user']
    group node['celery']['group']
    mode '0666'
    action :create_if_missing
    backup false
  end
else
  cookbook_file "#{node['celery']['workdir']}/#{node['celery']['app']}.py" do
    source "#{node['celery']['app']}.py"
    owner node['celery']['user']
    group node['celery']['group']
    mode '0666'
    action :create_if_missing
    # only pull this file in if it exists, otherwise just keep humming along
    ignore_failure true
  end
end

supervisor_service 'celery' do
  command [
    'celery worker',
    "-A #{node['celery']['app']}",
    "-I #{node['celery']['include']}",
    "--workdir=#{node['celery']['workdir']}"
  ].join ' '
  autostart node['celery']['autostart'] if node['celery']['autostart']
  action :enable
end
