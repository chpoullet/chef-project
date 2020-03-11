#
# Cookbook:: node_cookbook
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '16.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should apt_update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it 'should install nginx' do
      expect(chef_run).to install_package "nginx"
    end

    it 'enables the nginx service' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'starts the nginx service' do
      expect(chef_run).to start_service 'nginx'
    end

    it 'should create a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template("/etc/nginx/sites-available/proxy.conf").with_variables(proxy_port: 3000)
    end

    it 'should verify that a link was created' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with(to: "/etc/nginx/sites-available/proxy.conf")
    end

    it 'should remove the default link' do
      expect(chef_run).to delete_link "/etc/nginx/sites-enabled/default"
    end

    it 'should install nodejs from a recipe' do
      expect(chef_run).to include_recipe("nodejs")
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm('pm2')
    end





  end
=begin
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
=end
end
