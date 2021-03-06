
package "docker" do
  action :install
end

package "bridge-utils" do
  action :install
end

service "test_docker" do
  action :disable
end

template "/etc/sysconfig/docker" do
    mode "0644"
    owner "root"
    source "test_docker.erb"
end

