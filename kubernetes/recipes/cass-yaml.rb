  document_root = node['cassandra']['path']

  template "#{document_root}/cassandra.yaml" do
  source 'cassandra.yaml.erb'
  mode '644'
  variables(
   :private_ip => node['ipaddress'] ,
   :seed_node => node['cassandra']['seed_node'],
   :snitch_type => node['cassandra']['endpoint_snitch']
   )
  end

  template "#{document_root}/cassandra-rackdc.properties" do
  source 'cassandra-rackdc.properties.erb'
  mode '644'
  variables(
   :rack_num => node['cassandra']['rack'] ,
   :data_center => node['cassandra']['data_center']
   )
  end

  template "#{document_root}/logback.xml" do
  source 'logback.xml.erb'
  mode '644'
  variables(
   :cass_log => node['cassandra']['logs']
   )
  end
