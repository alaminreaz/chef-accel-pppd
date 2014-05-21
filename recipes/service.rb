#
# Cookbook Name:: accel-ppp
# Recipe:: service
# Author:: Rostyslav Fridman (<rostyslav.fridman@gmail.com>)
#
# Copyright 2014, Rostyslav Fridman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node[:platform]
  when "debian", "ubuntu"
    accel_init = "accel-ppp.init.debian.erb"
  when "redhat", "centos", "amazon", "scientific"
    accel_init = "accel-ppp.init.rhel.erb"
end

template "/etc/init.d/accel-ppp" do
  source accel_init
  owner  "root"
  group  "root"
  mode   00744
end

template "/etc/accel-ppp/accel-ppp.conf" do
  source "accel-ppp.conf.erb"
  owner  node[:accel][:user]
  group  node[:accel][:group]
  mode   00644
  notifies :restart, "service[accel-ppp]"
end

service "accel-ppp" do
  action [:enable, :start]
end