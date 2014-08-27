require 'spec_helper'

describe 'celery::default' do
  it 'should install python' do
    cmd = command 'which python'
    expect(cmd).to return_exit_status 0
  end

  it 'should create a celery directory' do
    expect(File).to be_directory('/var/celery')
  end

  it 'should create a celery tasks file' do
    expect(File).to exist('/var/celery/tasks.py')
  end

  it 'should have supervisor running' do
    expect(service 'supervisor').to be_running
  end
end
