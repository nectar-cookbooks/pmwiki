#
# Cookbook Name:: pmwiki
# Recipe:: default
#
# Copyright (c) 2014, The University of Queensland
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# * Neither the name of the The University of Queensland nor the
# names of its contributors may be used to endorse or promote products
# derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE UNIVERSITY OF QUEENSLAND BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

include_recipe 'lamp::base'

# In the first instance, just drop pmwiki into "a location accessible
# by the webserver" ... like the installation instructions say.  Maybe
# we ought to explicitly drop it into the CGI bin directory.

pmwiki_dir = node['apache']['docroot_dir']
pmwiki = "#{pmwiki_dir}/pmwiki"

version = node['pmwiki']['version'] 
zip_path = "#{Chef::Config['file_cache_path']}/#{version}.zip"
site = node['pmwiki']['site'] || 'default'
act = node['pmwiki']['action']
config = node['pmwiki']['config']
config_cookbook = node['pmwiki']['config_cookbook']

case act 
when 'install', 'upgrade'
else
  raise "Unknown action #{act}"
end

if act == 'install' && ::File.exists?(pmwiki) then
  log "PMWiki already installed as #{pmwiki}" do
    level :info
  end
else
  package 'unzip' do
    action :install
  end
  
  # For some reason 'remote_file' gives a redirection loop
  if false then
    remote_file zip_path do
      source "http://pmwiki.org/pub/pmwiki/#{version}.zip"
      action :create_if_missing 
    end
  else 
    bash "download #{zip_path}" do
      code "wget -O #{zip_path} http://pmwiki.org/pub/pmwiki/#{version}.zip"
      not_if { ::File.exists?(zip_path) }
    end
  end
  
  # (Only necessary if #{pmwiki_dir} is a non-standard place ...)
  directory pmwiki_dir do
    owner node['apache']['user']
  end
  
  # Figure out the real version
  ruby_block 'extract pmwiki version' do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
      raise "Can't find the ZIP file" unless ::File.exists?(zip_path)
      p = shell_out!("unzip -Z -1 #{zip_path} | head -n 1")
      real_version = %r{^[^/]+}.match(p.stdout)[0]
      node.override['pmwiki']['real_version'] = real_version
    end
    notifies :run, "bash[#{act} pmwiki]", :immediate
  end
  
  bash "#{act} pmwiki" do
    code lazy { <<-EOF
    cd #{pmwiki_dir}
    unzip #{zip_path}
    cp -a #{node['pmwiki']['real_version']} #{pmwiki}
    rm -rf #{node['pmwiki']['real_version']}
EOF
    }
    user node['apache']['user']
    action :nothing
    notifies :create_if_missing, "template[#{pmwiki}/local/config.php]", :immediate
  end

  template "#{pmwiki}/local/config.php" do
    cookbook config_cookbook if config_cookbook
    source "#{config}.php.erb"
  end
end

apache_site site do
  enable true
end
