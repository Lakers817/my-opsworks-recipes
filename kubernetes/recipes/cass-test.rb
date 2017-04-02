  ['data', 'commitlog', 'saved_caches'].each do |type|
  directory "/var/lib/cassandra/#{type}" do
   user 'ubuntu'
   group 'ubuntu'
   mode '755'
   recursive true
   action :create
  end
   end

 ["/var/log/cassandra", "/home/ubuntu/cassandra"].each do |type|
   directory type do
   user 'ubuntu'
   group 'ubuntu'
   mode '755'
   recursive true
   action :create
   end
    end

  execute 'install_cassandra' do
  user 'root'
  cwd '/tmp'
  command <<-EOH
  curl -OL http://www.apache.org/dist/cassandra/3.0.12/apache-cassandra-3.0.12-bin.tar.gz
  tar -xzvf apache-cassandra-3.0.12-bin.tar.gz
  mv apache-cassandra-3.0.12  /home/ubuntu/cassandra
  chown -R ubuntu:ubuntu /home/ubuntu/cassandra
  EOH
  end

   
