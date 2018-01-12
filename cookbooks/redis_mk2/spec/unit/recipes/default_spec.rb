#
# Cookbook Name:: redis
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'redis::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    it 'updates the package repository' do
      expect(chef_run).to run_execute('apt-get update')
    end
    it 'installs the necessary packages' do
      expect(chef_run).to install_package('build-essential')
      expect(chef_run).to install_package('tcl8.5')
    end

    #Replace '2.8.9' with version
    let(:version) { '2.8.9' }
    #But there is a way to replace it with node attribute !! TO DO !!!
    #HERE

    it 'retrieves the source code' do
      expect(chef_run).to create_remote_file("/tmp/redis-#{version}.tar.gz")
    end
    it 'unzips the application' do
      resource = chef_run.remote_file('/tmp/redis-2.8.9.tar.gz')
      expect(resource).to notify('execute[unzip_the_archive]').to(:run).immediately
    end
    it 'builds it' do
      resource = chef_run.execute('tar xzf redis-2.8.9.tar.gz')
      expect(resource).to notify('execute[make && make install]').to(:run).immediately
    end
    it 'installs the server' do
      resource = chef_run.execute('make && make install')
      expect(resource).to notify('execute[echo -n | ./install_server.sh]').to(:run).immediately
    end
    it 'starts the service' do
      expect(chef_run).to start_service('redis_6379')
    end
  end
end
