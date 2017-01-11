include_recipe 'kubernetes-rhel::test-master-setup'
include_recipe 'kubernetes-rhel::flanneld' 
#version newer than 0.5.2 won't pass etcd URL with BA

# ignore this if you don't want flanneld working on master node
#service 'flanneld' do
#	action :start
#end
bash 'start_flanneld' do
	user 'root'
	code <<-EOH	
	systemctl daemon-reload
	service flanneld start
	EOH
end

%w(kube-apiserver kube-controller-manager kube-scheduler).each do |service|
  service service do
    action [:enable, :restart]
     sleep(20)
  end
