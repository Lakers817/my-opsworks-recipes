%w(firewalld iptables).each do |service|
  service service do
    action [:stop, :disable]
  end
end
